// This Question is exactly(100%) same as Book Allocation Problem
// we solved this problem at Coding Ninja Platform link : https://www.codingninjas.com/studio/problems/painter-s-partition-problem_1089557



bool isPossibleSolution(vector<int> arr, int n, int k, int sol) {
    int unitWork = 0;
    int workerCount = 1;
    for(int i=0;i<n;i++) {
        // if sol is greater than current element then return false
        if(arr[i]>sol)
        return false;
        // if unitWork+arr[i] is greater than sol then store the cuurent element into 
        //unitWork variable and move to next student
        if((unitWork + arr[i])>sol) {
           
            workerCount++;
            unitWork = arr[i];
            // if current student count greater than totalStudent count then return false
            if(workerCount>k) {
                return false;
            }
            
        } else {
            // add the current page into unitWork
           unitWork += arr[i];
        }
        
    }
    //
    return true;
}
int findLargestMinDistance(vector<int> &boards, int k)
{
    int start = 0, n = boards.size(), ans = -1;
    // storing the sum of all elements in end variable
    int end = accumulate(boards.begin(), boards.end(), 0);

    while(start <= end) {
        int mid = start + (end - start)/2;
        // if possibleSolution is true then store the mid into ans var
        // and move to left to get minimum ans
        if(isPossibleSolution(boards, n, k, mid)) {
            ans = mid;
            end = mid - 1;
        }
         // else move to right 
        else {
            start = mid + 1;
        }
    }
    return ans;
}