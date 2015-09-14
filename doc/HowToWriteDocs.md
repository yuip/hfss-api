# How to do documentation

## Downloading and Installing Required software

To perform the documentation, please download

1. Doxygen -- [Doxygen Download Page](http://www.stack.nl/~dimitri/doxygen/download.html) -- download OS specific binary file
2. mtoc++ -- [mtoc++ Download Page](http://www.mathworks.com/matlabcentral/fileexchange/33826-mtoc++-doxygen-filter-for-matlab-and-tools) -- follow the instruction given on the page.
	**Note**: Please download the binaries only for mtoc++, since the tools are already included in the hfss-api project repo.

After installing the two required software, make sure that the executable of both the softwares are in Environment's PATH variable. If they are not, please add the executables to PATH. After adding them to the PATH, please restart Matlab.

There are some recommended softwares:

1. latex: To generate latex and pdf files.
2. Graphviz: To generate good function graphs.

However, without above softwares, it is going to work and it generates html files only. If you need to generate pdf file then, please install latex with pdf-latex. For Windows user, download MiKTex or texlive (both are good). For linux users, use apt-get to install texlive package.

## Using Config files and MatlabDocMaker.m
To config the Doc, open MatlabDocMaker.m (file contains a Matlab class) in Matlab. Change the current directory to directory containing the MatlabDocMaker.m. Now, at command window, run MatlabDocMaker.setup. It is going to take you through a wizard, using which you can configure the Documentation settings like source directory, output directory, etc. 

Settings for 'MatlabDocMaker.setup': This settings must be chosen while going through the wizard. Here, relative paths are provided.
Source Directory- repo directory. hfss-api
Destination Directory- hfss-api/doc/output
Config Directory - hfss-api/doc/Matlab_doc_generator/config 

If MatlabDocMaker.m generates error that doxygen or mtocpp are not found then, check the environment PATH variable. If the PATH variable has doxygen and mtocpp paths, then try restarting Matlab. When the MatlabDocMaker.setup reads the versions of doxygen and mtocpp, then you are good to go.

When you are done with the wizard, create the doc using function MatlabDocMaker.create. It should do.

## Sample function for explaining documentation tags
This section shows a sample function which will help you to understand how to use doxygen and mtocpp tags. Though, mtocpp supports tags for Matlab class, we are going to see the tags for function only because in our project till now there is no class defined. If wanna learn more please go through the link [Click here for more](https://github.com/mdrohmann/mtocpp/blob/master/src/docs/%2Bexamples/Class.m).

### Function Example
There is a example function provided in doc folder. It includes simple doxygen tags. However, you can use advanced doxygen tags.

### Important Note
* Documentation should be done after the declaration of function or you can say inside a function.
* Doxygen uses '\' in a similar way to '@'. So, don't use '\' while writing descriptions, since, doxygen take it as its tag and generates a warning.
* Don't use ':' while writing descriptions, because mtocpp parses semicolon ':' as 'param' and 'example'. If it finds that tag in description, it will parse it. I guess it's a bug of mtocpp.
* If you want to add some description to example, don't add it in between the code block, else add it before the code block and after "Example:" line.
* There is a doxygen tag for changelog, however, since for our project git is being used for version control, so in my opinion, writing changelog is not needed. 
* Don't use ' %--------- ' doxygen reads it, and generates various warnings. If you want to use it as a separator between your code and documentation block, please use it after a blank line as shown .

Don't worry about the advanced documenting tags, some of the files in this project has some complicated documentation tags and ways. Gradually, you will learn about it. If you have any doubts, read the .m files in this project.