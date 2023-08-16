/*
Given an array of integers arr, a lucky integer is an integer that has a frequency in the array equal to its value.

Return the largest lucky integer in the array. If there is no lucky integer return -1.

	Input: arr = [2,2,3,4]
	Output: 2
	Explanation: The only lucky number in the array is 2 because frequency[2] == 2.
*/

class Solution {
public:
    int findLucky(vector<int>& arr) {
        // first approach using loop
     /*   int maxi = -1;
        for(int i=0;i<arr.size();i++) {
            int count = 0;
            for(int j=0;j<arr.size();j++) {
                if(arr[i] == arr[j]) {
                    count++;
                }
            }
            if(arr[i] == count)
            maxi = max(maxi, count);
        }
        return maxi; */
        // second approach with extra space
        int maxi = -1;
        unordered_map<int, int> hash;
        for(int i=0;i<arr.size();i++) {
            hash[arr[i]]++;
        }
       for(auto x : hash) {
           if(x.first == x.second) {
                maxi = max(maxi, x.second);
           }
       }
       return maxi;
    }
};