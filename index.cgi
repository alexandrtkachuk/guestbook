#!/usr/bin/perl

use Template;
use File::Basename;
use Modules::GuestBook;
use Data::Dumper;
use warnings;
use strict;

use constant TDIR=>dirname(__FILE__);
my $template_path = 'templates';

my $view = new Template({
        INCLUDE_PATH => TDIR . '/' . $template_path  #Путь к каталогу с шаблонами
    });

my ($guest) =  Modules::GuestBook->new();
my $vars={
    title=>'Заголовок страницы',
    items=> $guest->getMessages()
};
my(@arr) = $guest->getMessages();
print Dumper @arr;



print "Content-type: text/html\n\n";
$view->process("guest.html", $vars);
                
            
#$guest->addMessage('sahaaa2', 'mail11ll@rambler.dfdsf', 'teeest.com', 'Hi wqeqw blablbababa', '1.2.2.1');
      
