SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BuscarCliente
	
	@inCedula		VARCHAR(128)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		C.ID,
		C.Nombre,
		C.Apellido,
		C.Cedula,
		C.Correo,
		C.Direccion,
		C.Telefono
	FROM Cliente C
	WHERE C.Cedula = @inCedula;
	
	SET NOCOUNT OFF
END
GO