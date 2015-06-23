explain select *
from basic;

#----------------------------------------------------------

explain select name
from basic;

#----------------------------------------------------------

explain select distinct name
from basic;

#----------------------------------------------------------

explain select *
from basic
where shop_id=10328540;

#----------------------------------------------------------

explain select *
from basic
where shop_id>10328540 and shop_id<10329940;

#----------------------------------------------------------

explain select *
from basic
where name='林师傅';

create index index_name on basic(name);

#----------------------------------------------------------

explain select name
from basic
where avg_price<50;

create index index_name_price on basic(avg_price,name);

#----------------------------------------------------------

explain select shop_id
from remark
where product_rating > 8.5 and environment_rating > 8.5;

create index index_product_rating on remark(product_rating);
create index index_environment_rating on remark(environment_rating);

#----------------------------------------------------------

explain select shop_id
from shop_id_small_cate_id
where small_cate_id in ('g101', 'g103', 'g105', 'g107');

#----------------------------------------------------------

explain select * from basic
where avg_price < 20
order by avg_price;

create index index_price on basic(avg_price);

#----------------------------------------------------------

explain select shop_id
from shop_id_city_id as SC, city_id_city as C
where SC.city_id = C.city_id and C.city = '上海';

create index index_city on city_id_city(city);
drop index index_city on city_id_city;

#----------------------------------------------------------

explain select city
from city_id_city as C
inner join city_id_city_pinyin as CP
where C.city_id = CP.city_id and CP.city_pinyin = 'shanghai';

create index index_city_pinyin on city_id_city_pinyin(city_pinyin);

#----------------------------------------------------------

explain select B.shop_id, B.name
from basic as B
where exists
(select *
from remark as R
where R.shop_id = B.shop_id and R.product_rating > 9);

create index index_product_rating on remark(product_rating);
drop index index_product_rating on remark;

explain select B.shop_id, B.name
from basic as B, remark as R
where R.shop_id = B.shop_id and R.product_rating > 9;

#----------------------------------------------------------

explain select shop_id
from (select * from dazhong where stars > 4.0) as D;

create index index_stars on dazhong(stars);

explain select shop_id
from dazhong where stars > 4.0;

#----------------------------------------------------------

explain insert into city_id_city(city_id, city)
values (1001, 'test');

#----------------------------------------------------------

explain delete
from city_id_city
where city_id = 1001 and city = 'test';

#----------------------------------------------------------

explain select count(city_id)
from shop_id_city_id
where city_id = 1;
