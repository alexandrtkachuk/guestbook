#!/usr/bin/perl

use Template;
use File::Basename;

use warnings;
use strict;

use constant TDIR=>dirname(__FILE__);
my $template_path = 'templates';

my $view = new Template({
        INCLUDE_PATH => TDIR . '/' . $template_path  #Путь к каталогу с шаблонами
    });
my $vars={
    title=>'Заголовок страницы',
    items=>['Один', 'Два', 'Три', '99']
};

print "Content-type: text/html\n\n";
$view->process("guest.html", $vars);
                
            

      
