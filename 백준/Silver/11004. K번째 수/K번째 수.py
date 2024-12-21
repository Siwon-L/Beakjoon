# n과 k 입력
n, k = map(int, input().split())

# 배열 입력
arr = list(map(int, input().split()))

# 배열 정렬
arr.sort()

# k번째 원소 출력
print(arr[k - 1])