// This problem is based on Book Allocation Problem solved at GFG platform link: https://practice.geeksforgeeks.org/problems/aggressive-cows/0

class Solution {
public:
    bool isPossibelSoution(vector<int> arr, int n, int k, int sol) {
        int sum = arr[0], cow = 1;
        for(int i=1;i<n;i++) {
            // if current position - previous postion(sum) bada ya barabar hai to next cow ko place krenge
            if(arr[i] - sum >= sol) {
                cow++;
                sum = arr[i];  // one more cow has been placed
            }
            if(cow == k) return true;
        }
        return false;
    }

    int solve(int n, int k, vector<int> &stalls) {
        sort(stalls.begin(), stalls.end());
        int start = 0, ans = -1;
        // end should be last element-first element
        int end = stalls[stalls.size()-1]-stalls[0];
        while(start<= end) {
            int mid = start + (end - start)/2;
            if(isPossibelSoution(stalls, n,k,mid)) {
                ans = mid;
                start = mid + 1;
            }else {
                end = mid - 1;
            }
        }
        return ans;
    }
};