SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BuscarCliente
	
	@inCedula		VARCHAR(128)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @outResultCode	INT = 0;

	IF NOT EXISTS (
		SELECT C.Cedula
		FROM [dbo].[Cliente] C
		WHERE BINARY_CHECKSUM(C.Cedula) = BINARY_CHECKSUM(@inCedula) 
		)
		BEGIN
			SET @outResultCode = 50006; -- Datos incorrectos
			SELECT @outResultCode;
		END;
	ELSE
	BEGIN

		SELECT
			C.Nombre,
			C.Apellido,
			C.Cedula,
			C.Correo,
			C.Direccion,
			C.Telefono
		FROM Cliente C
		WHERE C.Cedula = @inCedula;	

	END;
	
	SET NOCOUNT OFF
END
GO