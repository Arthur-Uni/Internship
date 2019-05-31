#!/bin/bash

# setup petalinux environment
source /home/arthur/tools/Petalinux/2018.2/settings.sh

echo -e "Enter project name: "
read PRJ_NAME
echo "Project name is $PRJ_NAME"

echo -e "Enter project template (zynq or zynqMP): "
read PRJ_TMPL
echo "Project template is $PRJ_TMPL"

echo "creating petalinux project with name $PRJ_NAME using template $PRJ_TMPL"
petalinux-create -t project -n $PRJ_NAME --template $PRJ_TMPL

DPU_GIT_PATH=/home/arthur/Petalinux_Projects/DPU-Integration/reference-files/files

echo "Copying necessary files from DPU integration tutorial..."
cp -rp $DPU_GIT_PATH/recipes-support $PRJ_NAME/project-spec/meta-user
cp -rp $DPU_GIT_PATH/recipes-devtools $PRJ_NAME/project-spec/meta-user
cp -rp $DPU_GIT_PATH/recipes-kernel $PRJ_NAME/project-spec/meta-user
cp -rp $DPU_GIT_PATH/recipes-apps/dnndk/ $PRJ_NAME/project-spec/meta-user/recipes-apps/
cp -rp $DPU_GIT_PATH/recipes-modules $PRJ_NAME/project-spec/meta-user
cp -rp $DPU_GIT_PATH/recipes-apps/autostart $PRJ_NAME/project-spec/meta-user/recipes-apps/
cp -rp $DPU_GIT_PATH/recipes-core/base-files/ $PRJ_NAME/project-spec/meta-user/recipes-core/
cp $DPU_GIT_PATH/petalinuxbsp.conf $PRJ_NAME/project-spec/meta-user/conf/
echo "Copying done"

echo "Modifying petalinux-image.bbappend..."
echo 'IMAGE_INSTALL_append = " dnndk"' >> $PRJ_NAME/project-spec/meta-user/recipes-core/images/petalinux-image.bbappend

echo 'IMAGE_INSTALL_append = " autostart"' >> $PRJ_NAME/project-spec/meta-user/recipes-core/images/petalinux-image.bbappend

echo 'IMAGE_INSTALL_append = " dpu"' >> $PRJ_NAME/project-spec/meta-user/recipes-core/images/petalinux-image.bbappend
echo "Modifications done"

cd $PRJ_NAME
