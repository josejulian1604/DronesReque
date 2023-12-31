USE [DronesReque]
GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 11/12/2023 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RegistrarUsuario]
	
	@inNombre		VARCHAR(128),
	@inApellido		VARCHAR(128),
	@inCorreo		VARCHAR(128),
	@inPassword		VARCHAR(128),
	@inRol			VARCHAR(60)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @outResultCode INT = 0;

	IF EXISTS (
		SELECT U.Correo
		FROM [dbo].[Usuario] U
		WHERE BINARY_CHECKSUM(U.Correo) = BINARY_CHECKSUM(@inCorreo) 
		)
		BEGIN
			SET @outResultCode = 50006; -- Ese Correo ya fue ingresado
			SELECT @outResultCode;
		END;
	
	ELSE
	BEGIN
		INSERT INTO [dbo].[Usuario] (
			[Nombre],
			[Apellido],
			[Correo],
			[Password],
			[IdTipoUsuario]
		)
		SELECT
			@inNombre,
			@inApellido,
			@inCorreo,
			@inPassword,
			TU.Id
		FROM [dbo].[TipoUsuario] TU
		WHERE (TU.Rol = @inRol);

		SET @outResultCode = 0; --Exitoso
		SELECT @outResultCode;
	END;
    
END