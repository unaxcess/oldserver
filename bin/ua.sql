drop table if exists event_item;
create table event_item
(
   eventid int not null,
   folderid int not null,
   
   eventtype int not null,   
   eventdate int not null,
   organiserid int not null,
   duration int not null,
   repeat int not null,
   min int not null,
   hour int not null,
   day int not null,
   
   eventtext mediumtext,
   
   edf text,
   
   primary key(eventid)
);


drop table if exists event_attend;
create table event_attend
(
   userid int not null,
   eventid int not null,
   attendtype char(1) not null,
   eventdate int not null,
	
   primary key(userid, eventid, eventdate),
	
   key userid_index(eventid),
   key eventid_index(eventid)
);
drop table if exists folder_item;
create table folder_item
(
   folderid int not null,
   parentid int not null,
   
   name varchar(30) not null,
   accessmode int not null,
   accesslevel int not null,
   created int not null,
   expire int not null,
   lastmsg int not null,
   lastedit int not null,
   lasteditid int not null,
   creatorid int not null,
   replyid int not null,
   maxreplies int not null,
   
   info_date int not null,
   info_id int not null,
   info_text text,
   
   edf text,
   
   primary key(folderid)
);

drop table if exists folder_sub;
create table folder_sub
(
   userid int not null,
   folderid int not null,
   subtype char(1) not null,
   extra int not null,
	
   primary key (userid, folderid)
);

drop table if exists folder_message_item;
create table folder_message_item
(
   messageid int not null,
   parentid int not null,

   folderid int not null,
   message_date int not null,
   fromid int not null,
   toid int not null,
   message_text mediumtext,
   
   subject varchar(110),

   edf text,
   
   primary key(messageid),
	
	key folderid_index(folderid),
	key fromid_index(fromid)
);

drop table if exists folder_message_read;
create table folder_message_read
(
   userid int not null,
   messageid int not null,
   marktype char(1) not null,
	
   primary key(userid, messageid),
	
   key userid_index(userid),
   key messageid_index(messageid)
);
drop table if exists service_sub;
create table service_sub
(
   userid int not null,
   serviceid int not null,
   subtype char(1) not null,
   extra int not null,
	
   primary key (userid, serviceid)
);
drop table if exists channel_item;
create table channel_item
(
   channelid int not null,
   parentid int not null,
   
   name varchar(30) not null,
   accessmode int not null,
   accesslevel int not null,
   created int not null,
   expire int not null,
   lastmsg int not null,
   lastedit int not null,
   lasteditid int not null,
   creatorid int not null,
   replyid int not null,
   maxreplies int not null,
   
   info_date int not null,
   info_id int not null,
   info_text text,
   
   edf text,
   
   primary key(channelid)
);

drop table if exists channel_sub;
create table channel_sub
(
   userid int not null,
   channelid int not null,
   subtype char(1) not null,
   extra int not null,
	
   primary key (userid, channelid)
);

drop table if exists channel_message_item;
create table channel_message_item
(
   messageid int not null,
   parentid int not null,   

   channelid int not null,

   type int not null,
   message_date int not null,
   fromid int not null,
   toid int not null,
   message_text text,
   
   edf text,
   
   primary key(messageid)
);
drop table if exists user_item;
create table user_item
(
   userid int not null,
   
   usertype int not null,
   name varchar(30) not null,
   password varchar(30),
   accesslevel int not null,
   accessname varchar(30),
   gender int not null,

   description text,
   
   created int not null,
   ownerid int not null,
   
   client varchar(30),
   hostname varchar(110),
   address int not null,
   location varchar(110),
   protocol varchar(30),
   secure int not null,
   timeon int not null,
   timeoff int not null,
   
   numlogins int not null,
   totallogins int not null,
   longestlogin int not null,
   nummsgs int not null,
   totalmsgs int not null,
   lastmsg int not null,
   numvotes int not null,
   
   periodnumlogins int not null,
   periodtotallogins int not null,
   periodlongestlogin int not null,
   periodnummsgs int not null,
   periodtotalmsgs int not null,
   periodlastmsg int not null,
   periodnumvotes int not null,
   
   edf text,
   
   primary key(userid)
);

drop table if exists user_login;
create table user_login
(
   userid int not null,
   timeon int not null,
   timeoff int not null,
   login_text varchar(110),
	
   key userid_index(userid)
);

drop table if exists user_stats;
create table user_stats
(
   userid int not null,
   timestart int not null,
   timeend int not null,
   
   numlogins int not null,
   totallogins int not null,
   longestlogin int not null,
   nummsgs int not null,
   totalmsgs int not null,
   lastmsg int not null,
   numvotes int not null,
   
   key userid_index(userid)
);
