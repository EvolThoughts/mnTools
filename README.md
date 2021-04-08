# mnTools

This is a toolbox for dealing with neuronal morphology.  It allows the importation of '.swc' and BBP '.h5' morphology files, the individual and population analysis (and figure generation) of the morphologies; the extraction of parameter/local measure relationships, and the algorithmic generation ("synthesis") of virtual neurons.

The code is currently in MATLAB, but I am slowly working to port it to Python.

Feel free to contact me with any questions: joe.w.graham@gmail.com

## Using mnTools

You will need to clone this repository, start MATLAB, change directories to ``mnTools/mnHelp``, and execute ``mnaddpaths``:

    git clone https://github.com/joewgraham/mnTools.git
    [start MATLAB]
    cd mnTools/mnHelp; mnaddpaths;

This will add the necessary ``mnTools`` paths to MATLAB and put you back in the main ``mnTools`` directory.

## Import a population of experimentally reconstructed motoneuron morphologies

Enter:

    mnimport
    
Type a name for the population and press return:

    real
    
Navigate to ``mnTools/mnInput/mns_real_virtual/real_burke``, select all files, and click ``Open``.

The six motoneuron morphologies will be imported and analyzed, resulting in the following in your MATLAB workspace: ``real_mnpop`` (the mnTools representation of the morphologies), ``real_data`` (the morphometric data, binned in a variety of ways), and ``real_analysis`` (a small object containing the results of analyzing the large data object).  The analysis object may be saved to file to allow plotting in other programs.

To see the analysis plots for these cells, enter:

    mnfigures(real_analysis)
    
The plots will be saved in a dated directory in ``mnTools/mnData``.


## Import a population of algorithmically generated motoneuron morphologies

Enter:

    mnimport
    
Type a name for the population and press return:

    virt
    
Navigate to ``mnTools/mnInput/mns_real_virtual/virtual_g``, select all files, and click ``Open``.

The 12 motoneuron morphologies will be imported and analyzed.  To see the analysis plots, enter:

    mnfigures(virt_analysis)
    

## Compare the real and virtual populations

Enter:

    mncompare(real_analysis, virt_analysis)

See the output in ``mnTools/mnData``.
