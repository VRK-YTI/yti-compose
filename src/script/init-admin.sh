#!/bin/bash
#
#
#----------------------------------
docker exec yti-postgres psql -U postgres -d groupmanagement -c "INSERT INTO public.user VALUES ('admin@localhost','Admin','User',true,null,null,'4ce70937-6fa4-49af-a229-b5f10328adb8')"
#----------------------------------
#----------------------------------
docker exec yti-postgres psql -U postgres -d groupmanagement -c "INSERT INTO public.organization (id,url,name_en,name_fi,name_sv) VALUES ('7d3a3c00-5a6b-489b-a3ed-63bb58c26a63','https://yhteentoimiva.suomi.fi/','Interoperability platform developers','Yhteentoimivuusalustan yllapito','Utvecklare av interoperabilitetsplattform')"
#----------------------------------
#----------------------------------
docker exec yti-postgres psql -U postgres -d groupmanagement -c "INSERT INTO public.user_organization VALUES ('7d3a3c00-5a6b-489b-a3ed-63bb58c26a63','ADMIN','4ce70937-6fa4-49af-a229-b5f10328adb8')"
#----------------------------------
