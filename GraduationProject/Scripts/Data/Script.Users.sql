IF NOT EXISTS (SELECT * FROM [dbo].[Users] WHERE [ExternalId] =  $(UserId1))
BEGIN
	EXECUTE [dbo].[InsertUser] 'Harry Potter', 'harry@hogwarts.com', $(UserId1)
END

IF NOT EXISTS (SELECT * FROM [dbo].[Users] WHERE [ExternalId] = $(UserId2))
BEGIN
	EXECUTE [dbo].[InsertUser] 'Hermione Granger', 'hermione@hogwarts.com', $(UserId2)
END

IF NOT EXISTS (SELECT * FROM [dbo].[Users] WHERE [ExternalId] = $(UserId3))
BEGIN
	EXECUTE [dbo].[InsertUser] 'Ron Weasley', 'ron@hogwarts.com', $(UserId3)
END

GO
