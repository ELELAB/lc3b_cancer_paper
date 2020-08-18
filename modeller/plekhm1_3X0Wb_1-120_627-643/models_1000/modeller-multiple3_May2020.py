#comparative modeling with multiple templates
from modeller import *              # Load standard Modeller classes
from modeller.automodel import *    # Load the automodel class
#select regions that should be optimized
class MyModel(automodel):
    def select_atoms(self):
        return selection(self) - selection(self.residue_range('1:A', '120:A'), self.residue_range('129:B', '132:B'))
#rename and renumber
    def user_after_single_model(self):
        self.rename_segments(segment_ids=('A', 'B'), renumber_residues=[1, 627])

env = environ()
# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

env.io.hetatm = True
# selected atoms do not feel the neighborhood
# env.edat.nonbonded_sel_atoms = 2

a = MyModel(env,
            alnfile  = 'xxx.ali', # alignment filename
            knowns   = ('3x0w_chainB_no_HOH_chainize.pdb'),     # codes of the templates
            sequence = 'lc3B_PLEKHM1')               # code of the target
a.starting_model= 1                 # index of the first model
a.ending_model  = 1000                # index of the last model
                                    # (determines how many models to calculate)
a.make()                            # do the actual comparative modeling
