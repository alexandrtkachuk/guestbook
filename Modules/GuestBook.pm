package Modules::GuestBook;

use strict;
use warnings;
use DBI;
#use NetAddr::IP::Util qw(:all);
use Socket;

sub new
{
    my $proto=shift;
    
    my $class = ref($proto) || $proto;
    
    my $self = {};

    my $data_source= "DBI:mysql:database=db_parser;host=192.168.58.1";
    my($user, $pass) = ('parser', 'tparser');
    $self->{'dbh'} = DBI->connect($data_source, $user, $pass, 
        {PrintError=>0, RaiseError=>0} #отключаем принт ошибок
    );
    


    bless($self,$class);
    
    return $self;
}


sub getMessages
{
    my $self = shift;
    my(@arr);
    my ($sth) = $self->{'dbh'}->prepare("SELECT id, name, email, homepage, text, time_add, INET_NTOA(ip), ip FROM  guestbook");
    $sth->execute();
    while (my $row = $sth->fetchrow_hashref()) 
    {   
        $row->{'ip'} = inet_ntoa(pack("N", $row->{'ip'})); 
        push @arr , $row;
        my $ip = $row->{'ip'};
        #print inet_ntoa(pack("N", $ip)), "\n";
    }
    $sth->finish();

    return ([@arr]);
    return ([
            {'name' =>'Один', 'email' => 'test@mail.com'} , 
            {'name' => 'Два', 'email' => 'test1@mail.com'}, 
            {'name' => 'Три', 'email' => 'test2@mail.com'}, 
            {'name' =>  '991', 'email' => 'test3@mail.com'}
        ] );
}

sub addMessage
{
    my $self = shift;
    my($name, $email, $homePage, $text, $ip) = @_;


    if($self->{'dbh'}) {
        #print "good\n";
        my ($sth) = $self->{'dbh'}->prepare("INSERT INTO `guestbook` (name, email, homepage, text, time_add, ip) "
            . "VALUES(?, ?, ?, ?, NOW(), ?)");
        my $result = $sth->execute($name, $email, $homePage, $text, unpack("N", inet_aton($ip))) or die $sth->errstr; 
        #print $result, "\n"; 
        $sth->finish();
        
    } else {
        print "error\n";
    }

}

sub DESTROY 
{
    my($self) = @_;
    if($self->{'dbh'}){
        $self->{'dbh'}->disconnect();
    }

    print "destruct\n";
}
      
1;
