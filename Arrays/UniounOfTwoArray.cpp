//  WAP to find the union of two array
#include <bits/stdc++.h>
using namespace std;
int main() {
    vector<int> arr1{1,3,4,6,8};
    vector<int> arr2{3,4,5,6,9};
    set<int> ans;
    
   for(int i=0;i<arr1.size();i++) {
       ans.insert(arr1[i]);
   }
   for(int i=0;i<arr2.size();i++) {
       ans.insert(arr2[i]);
   }
    for (auto itr = ans.begin(); itr != ans.end(); itr++)
        cout << *itr << " "; // ans will contain only distinct

    return 0;
}
/*

// WAP to find union of two array
#include <bits/stdc++.h>
using namespace std;
int main() {
    vector<int> arr{1,2,4,5,5,6,54};
    vector<int> brr{1,3,5,4,6,6,7,54};
    vector<int> ans;
    for(int i=0;i<arr.size();i++) {
        for(int j=0;j<brr.size();j++) {
            if(arr[i] == brr[j]) {
                brr[j] = -1;
                break;
            }
        }
    }
    for(int i=0;i<arr.size();i++) {
        ans.push_back(arr[i]);
    }
    for(int i=0;i<brr.size();i++) {
        if(brr[i] != -1)
        ans.push_back(brr[i]);
    }
    cout<<"Printing elements"<<endl;
    for(int i=0;i<ans.size();i++) {
        cout<<ans[i]<<" ";
    }
    return 0;
}









*/