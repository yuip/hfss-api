## Intro ##
The original version is from https://www.cresis.ku.edu/~rvc/projects/hfssapi/doc/hfss-matlab-api.html

When I started my PhD I needed to use it. But it lacked some features I needed, so I created this project to improve it a little bit and to share the code with everyone out there.

Shortly after that, I moved to use other stuff so I don't currently use HFSS and its Matlab API. Any new contributions are due to other people. If you want to contribute new features or fix bugs, drop me a line.

Another project forked from the original: https://bitbucket.org/jacobblock/hfssmatlabapi/overview

## Downloads ##
v0.4 (06-October-2014) [Download](https://drive.google.com/file/d/0B4TcZM-YZFPrZDc0TmVKUVhrZm8/view?usp=sharing)<br>
(Nothing lasts forever)<br>
- Added new function hfssSweepAlongVector.<br>
- Added hfssAssignLumpedRLC to boundary/ (thanks Pablo).<br>
- Added option to clone parts in hfssSubstract.<br>
- Added option for closed polylines.<br>
- Fixed crash in hfssAssignLumpedRLC (thanks Pablo).<br>
- Fixed representation of polylines.<br>

v0.3 (17-September-2013) <a href='https://docs.google.com/file/d/0B4TcZM-YZFPrbHJqSS0tMGxaTkU/edit?usp=sharing'>Download</a><br>
(Better late than never)<br>
- Added the following functions to boundary/ (thanks Pablo):<br>
<blockquote>hfssAssignMaster(...)<br>
hfssAssignSlave(...)<br>
hfssAssignFloquetPort(...)<br>
- Created global CHANGELOG file.<br>
- Added long-missing function hfssCalcStack(...) to fieldsCalculator/.<br>
- Added function hfssRemovePaths(...) to root directory.<br>
- Added relative path functionality to hfssIncludePaths(...) in root directory.<br>
- Fixed and reworked examples files and directories.<br>
- Added hfssThickenSheet function to 3dmodeler/ (thanks to Franz Schroeder).<br></blockquote>

v0.2 (28-May-2013): <a href='https://docs.google.com/file/d/0B4TcZM-YZFPrSGFkS1FQdHlNMjQ/edit?usp=sharing'>Download</a><br>
(This is the first version with public download. Sorry for the cryptic changelog.<br>
If you want to see the exact changes, please check the code until <a href='https://code.google.com/p/hfss-api/source/detail?r=32'>revision 32</a> at<br>
<a href='http://code.google.com/p/hfss-api/source/list'>http://code.google.com/p/hfss-api/source/list</a>)<br>
- Added a bunch of new functions.<br>
- Fixed a few bugs.