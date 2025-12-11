-- Demo for Data Type Conversions

select * from vw_Rushing;

-- convert the avg_ypg
select PLAYER, yards, avg_ypg, cast(avg_ypg as SIGNED)
from vw_RUSHING;

select PLAYER, yards, avg_ypg, convert(avg_ypg, SIGNED)
from vw_RUSHING;

select cast('2025-03-08' as datetime);
select cast('20250308' as datetime);
select cast('2025/03/08' as datetime);

select now(), convert(now(),DATE);

select '100' *5;

select '1 HUNDRED' *5;

select Player from vw_RUSHING;

select Player, substring(Player,1,5);
from vw_RUSHING;


-- using a substring with LOCATE

select Player, substring(Player, 1, locate(' ', Player))
from vw_RUSHING;

select Player, substring(Player, 1, locate(' ', Player)) as FIrstName,
substring(Player,locate(' ', Player) + 1) as LastName
from vw_RUSHING;

