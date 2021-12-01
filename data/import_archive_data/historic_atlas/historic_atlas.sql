/**********************************************************
 *  Import et structuration des données des anciens atlas  
 **********************************************************/


create schema historic_atlas;

-- import des fichiers csv dans le schéma src_historic_atlas

-- insertion des données de mailles dans le référentiel géographique

insert into ref_geo.bib_areas_types (type_name,type_code, type_desc)
values ('Maille IGN 50','GRPIGN150', 'Maillage IGN 50ème Lambert2 Etendu');

insert into ref_geo.l_areas (id_type, area_name, area_code, geom, centroid, enable)
select
	47
	, "CD_SIG" 
	, "CD_SIG"
	, (st_multi(geom))::geometry (multipolygon,4326)
	, st_centroid(geom)
	, false
from src_historic_atlas.grpign150 ;

-- creation d'une vue matérialisée de synthèse des données

create materialized view src_historic_atlas.historic_atlas as (
select 
	la.id_area 
	, g."CD_SIG" as code_maille
	, case when irc.date_inf ='1/1/1970 00:00:00' then '1970-1975'
		when irc.date_inf = '1/1/1985 00:00:00' then '1985-1989'
		else null end atlas_periode
	, sph.cd_nom
	, t.cd_ref
	, case 
		when irc2.indice_syn_label='Possible' then 'Nicheur possible'
		when irc2.indice_syn_label='Probable' then 'Nicheur probable'
		when irc2.indice_syn_label='Certaines' then 'Nicheur certain'
		end as	repro
	, la.geom
from src_historic_atlas.i037_releves irc
	left join src_historic_atlas.grpign150 g on irc.cd_sig =g."CD_SIG" 
	left join src_historic_atlas.i037_especes sph on sph.cd_releve =irc.cd_releve 
	left join src_historic_atlas.indice_reproduction irc2 on irc2.var_indnid::int = sph.var_indnid::int
	left join taxonomie.taxref t on t.cd_nom =sph.cd_nom
	left join ref_geo.l_areas la on la.area_code =g."CD_SIG" 
where irc.date_inf in ('1/1/1970 00:00:00','1/1/1985 00:00:00') and la.id_type =47	
)	;

comment on materialized view src_historic_atlas.historic_atlas is 'Données des atlas précédents, contient les mailles, les périodes et le statut max de reproduction par espèce';
