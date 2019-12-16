drop procedure if exists dbo.sp_GetFavoriteNumbers
go

create procedure sp_GetFavoriteNumbers

@Operation varchar(25),
@vcPhoneNumber varchar(25),
@vcFavoriteNumber1 varchar(25),
@vcFavoriteNumber2 varchar(25),
@vcFavoriteNumber3 varchar(25),
@vcFavoriteNumber4 varchar(25),
@vcFavoriteNumber5 varchar(25),

@vcFavoriteNumber1forUpdate varchar(25),
@vcFavoriteNumber2forUpdate varchar(25),
@vcFavoriteNumber3forUpdate varchar(25),
@vcFavoriteNumber4forUpdate varchar(25),
@vcFavoriteNumber5forUpdate varchar(25)

as 
Begin


  if not exists( select  vcPhoneNumber  FROM [BlueMobile].[dbo].[SimCards] where  vcPhoneNumber=@vcPhoneNumber)

		Raiserror ('Phone number not exists !',16,1)

  ELSE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

	Begin Try
		Begin Transaction


  Declare @iSimCardID int   
  select  @iSimCardID=iSimCardID  FROM [BlueMobile].[dbo].[SimCards] where  vcPhoneNumber=@vcPhoneNumber
  Declare @MaxNumberFav int=(select count(iSimCardIDFK)   FROM [BlueMobile].[dbo].[FavoriteNumbers] where  iSimCardIDFK=@iSimCardID)
  Declare @MaxLimit tinyint=5;
  Declare @Limit tinyint=0
  set @Limit=@MaxLimit-@MaxNumberFav;

  if(@Operation='INSERT')
 Begin

insert into [BlueMobile].[dbo].[FavoriteNumbers] (iSimCardIDFK,vcFavoriteNumber)
select iSimCardIDFK,vcFavoriteNumber
from
(
	select ROW_NUMBER () over (order by vcFavoriteNumber) as ID, iSimCardIDFK, vcFavoriteNumber
	from
	(
  
   select @iSimCardID as iSimCardIDFK,@vcFavoriteNumber1 as vcFavoriteNumber
   union all
   select @iSimCardID as iSimCardIDFK,@vcFavoriteNumber2 as vcFavoriteNumber
   union all
   select @iSimCardID as iSimCardIDFK,@vcFavoriteNumber3 as vcFavoriteNumber
   union all
   select @iSimCardID as iSimCardIDFK,@vcFavoriteNumber4 as vcFavoriteNumber
   union all
   select @iSimCardID as iSimCardIDFK,@vcFavoriteNumber5 as vcFavoriteNumber
    ) as A
	) as B where ID <=@Limit
   	
	print 'insert realizat'
	--print 'pentru sim-ul cu id = ' +cast(@iSimCardID as varchar(10)) +' am = '+cast(@MaxNumberFav as varchar(10))+' numere favorite !'
		
end

	  if(@Operation='UPDATE')
	  BEGIN

	update [BlueMobile].[dbo].[FavoriteNumbers]

	 set vcFavoriteNumber = (CASE
								
								  when  vcFavoriteNumber= @vcFavoriteNumber1  then	@vcFavoriteNumber1forUpdate
								  when  vcFavoriteNumber= @vcFavoriteNumber2  then  @vcFavoriteNumber2forUpdate
								  when  vcFavoriteNumber= @vcFavoriteNumber3  then  @vcFavoriteNumber3forUpdate
								  when  vcFavoriteNumber= @vcFavoriteNumber4  then  @vcFavoriteNumber4forUpdate
	                              when  vcFavoriteNumber= @vcFavoriteNumber5  then  @vcFavoriteNumber5forUpdate 

	
							ELSE (vcFavoriteNumber)
			                END)
      WHERE vcFavoriteNumber IN (@vcFavoriteNumber1,@vcFavoriteNumber2,@vcFavoriteNumber3,@vcFavoriteNumber4,@vcFavoriteNumber5) AND iSimCardIDFK=@iSimCardID


	  
	  print 'update realizat'

	
	END
			Commit Transaction

	End try
	Begin catch
		Rollback Transaction
		print 'am intrat in rollback - probleme'
	End catch
End


