
import os, os.path

from Definitions       import dataPathM
from pBabel            import ImportSystem
from pCore             import logFile      , \
                              Selection
from pMolecule.MMModel import MMModelOPLS
from pMolecule.NBModel import NBModelORCA
from pMolecule.QCModel import QCModelORCA



# . Header.
logFile.Header ( )

# . Define the MM, NB and QC models.
mmModel = MMModelOPLS.WithParameterSet ( "bookSmallExamples" )
nbModel = NBModelORCA.WithDefaults ( )
qcModel = QCModelORCA.WithOptions ( keywords = [ "B3LYP", "OPT" ] )

# . Define the molecule.
molecule = ImportSystem ( os.path.join ( dataPathM, "mol", "water.mol" ) )

# . Define the selection for the first molecule.
firstWater = Selection.FromIterable ( [ 0, 1, 2 ] )

# . Define the energy model.
molecule.DefineMMModel ( mmModel )
molecule.DefineQCModel ( qcModel, qcSelection = firstWater )
molecule.DefineNBModel ( nbModel )
molecule.Summary ( )

# . Calculate an energy.
molecule.Energy ( doGradients = True )

# . Footer.
logFile.Footer ( )

