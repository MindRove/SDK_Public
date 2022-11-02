
# MindRove (& neuroLeet) SDK


The <b>[MindRove](https://mindrove.com/)</b>/<b>[neuroLeet](https://neuroleet.gg/)</b> SDK has <b>[Brainflow](https://github.com/brainflow-dev/brainflow)</b>  as it's base framework. 

On top of Brainflow, we integrated the following board: 
> MINDROVE_WIFI_BOARD

## Compatibility 
If you received your device before **2021.11.03** (Y/m/d) (and have not updated your firmware yet) the current SDK release is not compatible with your device, please consider updating your firmware (<info@mindrove.com>) or using the [Release v1.0.0](https://github.com/MindRove/SDK_Public/releases/tag/v1.0.0)

## Installation 
### Python 
 To install the Mindrove specific version of brainflow run the following command in your shell: 

    pip install mindrove-brainflow

This will install the `mindrove_brainflow` package and you can access it ( examples are provided under the /examples/python folder )

### C# 
To start using the MindRove specific C# library, 
- Step 1. - in your C# project in Visual Studio Solution Explorer `right click on References -> Add Reference -> Browse (left panel ) -> Click Browse ( near Ok button ) -> select win64/cs-bin/mindrove-brainflow.dll`
- Step 2. -  copy the dlls from win64/lib to the folder where your .exe was generated. 

For a more comfortable usage, recommended to use **post-build event**s ( change %SDK_PUBLIC_LIB% with your path to the SDK_Public repository/win64/lib ) : 

    for /r "%SDK_PUBLIC_LIB%" %%f in (*.dll) do @xcopy "%%f" "$(TargetDir)" /Y

## Get started!
For using the SDK we provided the binaries for x64 win systems in win64/ and for linux in linux/ folder

To get started, we provided a C# code as a standalone example and the same code integrated into Unity. You can find these examples under the examples/ folder. 

## Further documentation
For further custom functionalities and ***MindRove specific*** documentation please visit our [Github Wiki Page](https://github.com/MindRove/SDK_Public/wiki). 

## Commands
If you installed this SDK, you can use the usual commands of BrainFlow: https://brainflow.readthedocs.io/en/stable/

## Contribute
For any bugs or if the rest of the platform binaries are needed, please make an issue.

