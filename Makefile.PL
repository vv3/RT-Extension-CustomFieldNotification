use inc::Module::Install;

RTx     'RT-Extension-CustomFieldNotification';
license 'gplv2';

requires_rt '4.2.12';
rt_too_new '4.4.0';

sign;
WriteAll;
