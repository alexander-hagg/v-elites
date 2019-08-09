%% buildingBreed Stopping Criteria
function [shouldYouStop] = buildingBreed_StopCriteria(elite,~,~)
shouldYouStop = (elite(1).fitness == 1);
