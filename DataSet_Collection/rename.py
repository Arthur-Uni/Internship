import os

path = 'O:\Docs\Seminars\AI_internship\Synthara_collaboration\Data_Set\Backup\ILLEGAL'
files = os.listdir(path)

for index, file in enumerate(files):
	os.rename(os.path.join(path,file), os.path.join(path, 'ILLEGAL'+str(format(index, '04'))+'.jpg'))
	print(index)