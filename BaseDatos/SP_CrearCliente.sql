SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE CrearCliente
	
	@inNombre		VARCHAR(128),
	@inApellido		VARCHAR(128),
	@inCedula		VARCHAR(128),
	@inCorreo		VARCHAR(128),
	@inDireccion	VARCHAR(128),
	@inTelefono		VARCHAR(128)
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO [dbo].[Cliente] (
		[Nombre],
		[Apellido],
		[Cedula],
		[Correo],
		[Direccion],
		[Telefono]
	)
	SELECT
		@inNombre,
		@inApellido,
		@inCedula,
		@inCorreo,
		@inDireccion,
		@inTelefono
END
GO