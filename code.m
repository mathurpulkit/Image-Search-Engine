alpha = 0.935;  % variable that decides minimum similarity condition of vectors
% value of alpha has been decided based on experimental observations
totimg = 29; % total number of images across all datasets
totfolder = 4; %total number of folders in the dataset
%file reading starts here
dataset = cell(totimg); % variable holding image data
foldet = ["BBT","Hobbit","HouseMD","TSimpsons"]; %array of folder names to be accessed
k=1; % for dataset of images
for i = 1:totfolder %this array reads all images from all the folders
    oldf = cd(foldet(i)); % oldf stores older folder link and navigates to each folder for image reading
    imagefiles = dir('*.jpg');      
    nfiles = length(imagefiles);    % Number of files found
    for j=1:nfiles %loop scans all jpg files from each folder
        currentfilename = imagefiles(j).name; %gets each filename for imread
        dataset{k}= imread(currentfilename); %reads each image and stores it in the dataset
        k=k+1; %increments counter for dataset of images
    end
    cd(oldf); %navigates back to old folder
end
%file reading ends here
%each dataset image is processed for creating 3 histograms, each for R,G,B
%merging to form a single feature vector
thist = cell(totimg,1); %feature vector
for k = 1:totimg
    rchan = dataset{k}(:,:,1); %filters out colors of the image into 3 separate vectors
    gchan = dataset{k}(:,:,2);
    bchan = dataset{k}(:,:,3);
    %Get histogram for each channel r,g,b
    rhist = imhist(rchan);
    ghist = imhist(gchan);
    bhist = imhist(bchan);
    thist{k} = [rhist; ghist; bhist]; %merges the histogram to form a single 768-D vector
end
%user input here
prompt = 'Enter image address which you want to search: ';
imgadd = inputdlg(prompt,'Input Image Address'); %opens dialog  box for user input of query image address
inpimg = imread(imgadd{1}); %inpimg stores query image data
%now query image's histogram is taken
rchan = inpimg(:,:,1);
gchan = inpimg(:,:,2);
bchan = inpimg(:,:,3);
%Get histogram for each channel r,g,b
rhist = imhist(rchan);
ghist = imhist(gchan);
bhist = imhist(bchan);
inphist = [rhist; ghist; bhist]; %merges query image histograms into single feature vector
%now comparison is started
for k = 1:totimg
   %cosine distance code starts here
   %cosine distance is calculated by
   %sum(Ai*Bi)/(sum(root(Ai^2))*sum(root(Bi^2))
   answer = sum(sum(inphist.*thist{k}))/((sum(sum(inphist.^2))*sum(sum(thist{k}.^2)))^0.5);
   %cosine test code ends here
   if (answer>=alpha&&answer~=1) %checks whether dataset image is similar to query image
       %and displays it if it is similar, but skips if it is the same image
       %comparison  whether cosine is greater than min value specified
       figure % used so that each output image is displayed in a separate window
       imshow(dataset{k}); %shows the image
   end
end