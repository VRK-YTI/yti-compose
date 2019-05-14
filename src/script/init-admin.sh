#!/bin/bash
#
#----------------------------------
docker exec yti-postgres psql -U postgres -d groupmanagement -c "INSERT INTO public.user VALUES ('admin@localhost','Admin','User',true,null,null,'4ce70937-6fa4-49af-a229-b5f10328adb8')"
#----------------------------------
#----------------------------------
docker exec yti-postgres psql -U postgres -d groupmanagement -c "INSERT INTO public.organization  (id,name_en,name_fi) VALUES ('25e2373c-537d-4129-ab82-c28b97d00c5f','Platform administration','Alustan yllapito')"
#----------------------------------
#----------------------------------
docker exec yti-postgres psql -U postgres -d groupmanagement -c "INSERT INTO public.user_organization VALUES ('25e2373c-537d-4129-ab82-c28b97d00c5f','ADMIN','4ce70937-6fa4-49af-a229-b5f10328adb8')"
#----------------------------------