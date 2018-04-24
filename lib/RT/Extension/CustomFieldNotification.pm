use strict;
use warnings;
package RT::Extension::CustomFieldNotification;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-CustomFieldNotification - Notify external parties when CF is set


=head1 DESCRIPTION

You want to notify some external parties when a ticket CF is set and matches some values.

Requires a list of CF-values and corresponding email adresses. 
Example:


    Set($CustomFieldNotifications,
        { 
         cfname1 => {
                     'cfvalue11' => [ 'email111@company.com', 'email112@company.com', ],
                     'cfvalue12' => [ 'email111@company.com', 'email112@company.com', ],
                    },
         cfname2 => {
                     'cfvalue21' => [ 'email111@company.com', 'email112@company.com', ],
                     'cfvalue22' => [ 'email111@company.com', 'email112@company.com', ],
                    },
        });

When a CF is set, and matches a value in the list, this extension
looks up matching email adresses. If found, adds them as CC to Ticket,
and sends a email, based on the "Notify custom parties" template.


=head1 RT VERSION

Works with RT 4.2.12

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

If you are using RT 4.2 or greater, add this line:

    Plugin('RT::Extension::CustomFieldNotification');

For RT 4.0, add this line:

    Set(@Plugins, qw(RT::Extension::CustomFieldNotification));

or add C<RT::Extension::CustomFieldNotification> to your existing C<@Plugins> line.

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

=head1 AUTHOR

Vegard Vesterheim, UNINETT <vegardv@uninett.no>


=head1 BUGS

All bugs should be reported via email to

    L<Vegard Vesterheim|mailto:vegardv@uninett.no>


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2017 by Vegard Vesterheim

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
