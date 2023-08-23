// problem solved from conding Ninja's site --> https://www.codingninjas.com/studio/problems/allocate-books_1090540?leftPanelTab=0


bool isPossibleSolution(vector<int> arr, int n, int m, int sol) {
    int pageSum = 0;
    int studentCount = 1;
    for(int i=0;i<n;i++) {
        // if sol is greater than current element then return false
        if(arr[i]>sol)
        return false;
        // if pageSum+arr[i] is greater than sol then store the cuurent element into 
        //pageSum variable and move to next student
        if((pageSum + arr[i])>sol) {
           
            studentCount++;
            pageSum = arr[i];
            // if current student count greater than totalStudent count then return false
            if(studentCount>m) {
                return false;
            }
            
        } else {
            // add the current page into pageSum
           pageSum += arr[i];
        }
        
    }
    //
    return true;
}
int findPages(vector<int>& arr, int n, int m) {
    if(n<m) return -1;
    int start = 0;
    int ans = -1;
    // storing the sum of all elements in end variable
    int end = accumulate(arr.begin(),arr.end(),0);
    while(start<=end) {
        int mid = start + (end - start)/2;
        // if possibleSolution is true then store the mid into ans var
        // and move to left to get minimum ans
        if(isPossibleSolution(arr, n, m, mid)) {
            ans = mid;
            end = mid -1;
        }
        // else move to right 
        else {
            start = mid + 1;
        }
    }
    // finally return the ans
    return ans;
}