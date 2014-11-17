#TP6 Caron Matthieu 

#Question 1 
create view participationActeur as 
select aid as artiste, count(aid) as nbpart 
from artists natural join roles natural join films
where artists.aid in 
(select aid from roles where roles.fid in
(select fid from films)) 
or artists.aid in
(select realisateur from films)
group by 
artists.aid ;

create view participationRealisateur as
select aid as artiste, count(aid) as nbpart
from films natural join artists
where artists.aid in 
(select realisateur from films)
group by 
artists.aid ;


create view participation as
select * from  participationActeur
union
select * from participationRealisateur ;

select artiste,nbpart from participation
where nbpart >= ALL(select nbpart from participation)
group by artiste,nbpart;

#Question 2 
#j avais un warning quand je mettais 'films d\'action'

update films set genre='films d action' 
where fid in (select fid from roles where protagoniste=true);

#Question 3

select distinct(aid) from roles except (select distinct(aid) from roles where protagoniste=true);

#Question 4

update films set genre='film national'
