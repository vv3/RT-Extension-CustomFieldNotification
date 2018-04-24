use strict;
use warnings;

package RT::Condition::CFMatch;
use base qw(RT::Condition);

=head1 IsApplicable

=cut

sub IsApplicable {
    my $self = shift;

    my $trans = $self->TransactionObj;
    my $ticket = $self->TicketObj;

    my @cf_values;
    my $is_applicable;
    my $cf_config = RT->Config->Get('CustomFieldNotifications');

    foreach my $cf (keys %$cf_config) {
        if ( $trans->Type eq 'Create' ) { # CF can be set on create
            my @cf_values = map {$_->Content} @{ $ticket->CustomFieldValues($cf)->ItemsArrayRef };
            next unless scalar @cf_values;
        } elsif ($trans->Type eq 'CustomField') {
            my $ticket_cf = RT::CustomField->new( $self->CurrentUser );
            $ticket_cf->Load( $trans->Field );
            next unless $ticket_cf->Name eq $cf;
            push @cf_values, $trans->NewValue();
        }

        foreach my $cf_value (@cf_values) {
            $RT::Logger->info(sprintf 'CF %s has been set to %s',$cf, $cf_value);
            if (my $ccs = $cf_config->{$cf}->{$cf_value}) {
                foreach my $cc (@$ccs) {
                    $RT::Logger->info ("Adding $cc as CC from scrip");
                    my ($success, $msg)= $ticket->AddWatcher
                        (
                         Type => "Cc",
                         Email => $cc,
                        );
                    if (! $success) {
                        $RT::Logger->error($msg);
                    } else {
                        $is_applicable = 1;
                    }
                }
            }
        }
    }
    return $is_applicable;
}

1;
