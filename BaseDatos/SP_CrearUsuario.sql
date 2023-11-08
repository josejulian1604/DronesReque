SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE RegistrarUsuario
	
	@inNombre		VARCHAR(128),
	@inApellido		VARCHAR(128),
	@inCorreo		VARCHAR(128),
	@inPassword		VARCHAR(128),
	@inRol			VARCHAR(60)
AS
BEGIN
	
	SET NOCOUNT ON;

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
END
GO