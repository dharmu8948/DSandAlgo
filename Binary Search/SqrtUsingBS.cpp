// WAP to find the Square root of a given number
#include <bits/stdc++.h>
using namespace std;
int findSqrt(int n) {
    int start =0, end =n;
    int ans;
    while(start<=end) {
        int mid = start + (end - start)/2;
        int sqRoot = mid*mid;
        if(n == sqRoot) {
            return mid;
        }else if(n>sqRoot) {
            ans = mid;
            start = mid + 1;
        }else {
            end = mid - 1;
        }
    }
    return ans;
}
int main() {
    int number;
    cout<<"Enter a number: "<<endl;
    cin>>number;
    int ans = findSqrt(number);
    cout<<"Square root in Integer form is : "<<ans<<endl;
    int precision;
    cout<<"Enter the precision"<<endl;
    cin>>precision;
    double step = 0.1;
    double finalAns = ans;
    for(int i=0;i<precision;i++) {
        for(double j =finalAns;j*j<=number;j = j+step) {
            finalAns = j;
        }
        step = step/10;
    }
    cout<<"Square Root in Decimal form is: "<<finalAns<<endl;
    return 0;
}