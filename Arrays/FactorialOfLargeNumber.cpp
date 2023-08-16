// https://practice.geeksforgeeks.org/problems/factorials-of-large-numbers2508/1

class Solution {
public:
    vector<int> factorial(int N){
        int carry = 0;
        vector<int> ans;
        ans.push_back(1);
        
        for(int i=2;i<=N;i++) {
           for(int j=0;j<ans.size();j++) {
               int x = ans[j]*i + carry;
               ans[j] = x%10;
               carry = x/10;
           }
           while(carry) {
               ans.push_back(carry%10);
               carry /= 10;
           }
           carry = 0;
        }
        reverse(ans.begin(), ans.end());
        return ans;
    }
};