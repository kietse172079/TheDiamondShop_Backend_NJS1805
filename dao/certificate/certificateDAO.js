const sql = require("mssql");
const config = require("../../config/dbconfig");

class certificateDAO {
  async addCertificate(cert) {
    try {
      let pool = await sql.connect(config);
      let addcert = await pool
        .request()
        .input("InspectionDate", sql.Date, cert.InspectionDate)
        .input("ClarityGrade", sql.VarChar, cert.ClarityGrade)
        .input("ShapeAndCuttingStyle", sql.VarChar, cert.ShapeAndCuttingStyle)
        .input("GIAReportNumber", sql.VarChar, cert.GIAReportNumber)
        .input("Measurements", sql.VarChar, cert.Measurements)
        .input("CaratWeight", sql.VarChar, cert.CaratWeight)
        .input("ColorGrade", sql.VarChar, cert.ColorGrade)
        .input("SymmetryGrade", sql.VarChar, cert.SymmetryGrade)
        .input("CutGrade", sql.VarChar, cert.CutGrade)
        .input("PolishGrade", sql.VarChar, cert.PolishGrade)
        .input("Fluorescence", sql.VarChar, cert.Fluorescence)
        .query(
          "INSERT INTO Certificate(InspectionDate, ClarityGrade, ShapeAndCuttingStyle, GIAReportNumber, Measurements, CaratWeight, ColorGrade, SymmetryGrade, CutGrade, PolishGrade, Fluorescence, ImageLogoCertificate) VALUES(@InspectionDate, @ClarityGrade, @ShapeAndCuttingStyle, @GIAReportNumber, @Measurements, @CaratWeight, @ColorGrade, @SymmetryGrade, @CutGrade, @PolishGrade, @Fluorescence, 'https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Logo%2FGIA-Logo.jpg?alt=media&token=f43782e9-589b-4e3f-b35c-5c11a36950d0')"
        );
      if (addcert.rowsAffected[0] > 0) {
        return {
          status: true,
          message: "The certificate has been added successfully",
        };
      } else {
        return { status: false, message: "The certificate cannot be added" };
      }
    } catch (error) {
      console.error("Error creating event:", error);
      throw error;
    }
  }
  // async getcertByNum(reportNO) {
  //     try {
  //         const pool = await sql.connect(config);
  //         const certNO = await pool.request()
  //             .input('GIAReportNumber', sql.NVarChar, reportNO.GIAReportNumber)
  //             .query('SELECT GIAReportNumber, InspectionDate, ClarityGrade, ShapeAndCuttingStyle, Measurements, CaratWeight, ColorGrade, SymmetryGrade, CutGrade, PolishGrade, Fluorescence FROM Certificate WHERE GIAReportNumber = @GIAReportNumber');
  //         return certNO.recordset;

  //     } catch (err) {
  //         console.log(err);
  //         return { message: 'cert not Available' };
  //     }
  // }

  async getCertificateByCertificateID(CertificateID) {
    try {
      const pool = await sql.connect(config);
      const result = await pool
        .request()
        .input("CertificateID", sql.Int, CertificateID)
        .query(
          `SELECT c.*,
		b.BridalStyle,
		b.Category,
		b.ImageBridal,
		b.Description AS Bridal,
		d.DiamondOrigin,
		d.StockNumber,
		d.Descriptors,
		d.Image,
		dr.RingStyle,
		dr.NameRings,
		dr.Description AS DiamondRings,
		dr.ImageRings,
		t.TimepiecesStyle,
		t.DialColor,
		t.Description AS DiamondTimepieces,
		t.ImageTimepieces
		FROM Certificate c
				 LEFT JOIN Bridal b ON c.BridalID = b.BridalID
				 LEFT JOIN DiamondRings dr ON dr.DiamondRingsID = c.DiamondRingsID
				 LEFT JOIN Diamond d	ON d.DiamondID = c.DiamondID
				LEFT JOIN DiamondTimepieces t ON t.DiamondTimepiecesID = c.DiamondTimepiecesID
    WHERE c.CertificateID = @CertificateID;`
        );
      return result.recordset[0];
    } catch (err) {
      throw new Error("Error fetching certificate: " + err.message);
    }
  }

  async getCertificate() {
    try {
      let pool = await sql.connect(config);
      let products = await pool.request().query("SELECT * FROM Certificate");
      return products.recordsets;
    } catch (error) {
      console.error("SQL error", error);
      throw error;
    }
  }

  async updatecert(CertificateID, cert) {
    try {
      let pool = await sql.connect(config);
      let updatecert = await pool
        .request()
        .input("CertificateID", sql.VarChar, CertificateID)
        .input("InspectionDate", sql.Date, cert.InspectionDate)
        .input("ClarityGrade", sql.VarChar, cert.ClarityGrade)
        .input("ShapeAndCuttingStyle", sql.VarChar, cert.ShapeAndCuttingStyle)
        .input("GIAReportNumber", sql.VarChar, cert.GIAReportNumber)
        .input("Measurements", sql.VarChar, cert.Measurements)
        .input("CaratWeight", sql.Decimal(5, 2), cert.CaratWeight)
        .input("ColorGrade", sql.VarChar, cert.ColorGrade)
        .input("SymmetryGrade", sql.VarChar, cert.SymmetryGrade)
        .input("CutGrade", sql.VarChar, cert.CutGrade)
        .input("PolishGrade", sql.VarChar, cert.PolishGrade)
        .input("Fluorescence", sql.VarChar, cert.Fluorescence)
        .input(
          "ImageLogoCertificate",
          sql.VarChar(sql.MAX),
          cert.ImageLogoCertificate
        )
        .query(
          `UPDATE Certificate 
          SET
          InspectionDate = @InspectionDate,
          ClarityGrade = @ClarityGrade, 
          ShapeAndCuttingStyle = @ShapeAndCuttingStyle,
          GIAReportNumber = @GIAReportNumber,
          Measurements = @Measurements, 
          CaratWeight = @CaratWeight, 
          ColorGrade = @ColorGrade, 
          SymmetryGrade = @SymmetryGrade, 
          CutGrade = @CutGrade, 
          PolishGrade = @PolishGrade, 
          Fluorescence = @Fluorescence,
          ImageLogoCertificate = @ImageLogoCertificate
          WHERE CertificateID = @CertificateID`
        );
      if (updatecert.rowsAffected[0] > 0) {
        return {
          status: true,
          message: "The certificate has been updated successfully",
        };
      } else {
        return { status: false, message: "The certificate cannot be updated" };
      }
    } catch (err) {
      console.log(err);
      return { message: "cert not Available" };
    }
  }
}

module.exports = new certificateDAO();
