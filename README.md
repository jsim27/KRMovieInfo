# KRMovieInfo
# [Step 0] 기획,  API 활용 계획 및 설계

## 1. 기획

### 1. 기능

#### 1. 영화 색인
영화명, 감독명 검색어를 통해 영화 목록을 색인하여 해당 영화의 상세 정보를 보여준다
(상세 정보: 제목, 감독, 장르, 제작국가, 제작연도, 개봉연도, 출연진, 배역, 관람등급, 참여 영화사, 스텝, 포스터)
#### 2. 영화 리스트
좋아요 표시를 통해 저장하고싶은 영화 정보를 별도의 로컬 리스트에 저장할 수 있다.
#### 3. 일간 박스오피스 순위
전일 일간 박스오피스 순위를 보여준다
#### 4. 주간 박스오피스 순위
금주 주간 박스오피스 순위를 보여준다
#### 5. 사용자 설정 
사용자 설정

### 2. 디자인 시안
![image](https://user-images.githubusercontent.com/72993238/164691765-efdef9df-b0ba-4daf-8ec8-18c83ff6a3fd.png)

### 3. API 활용 계획

- 영화진흥위원회 오픈API ([https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do))의 영화목록 API를 활용하여 핵심 기능인 영화 검색기능을 구현합니다. 다만, API에서 제공하지 않는 영화 포스터 썸네일을 보완하기 위하여, 네이버 검색 API - 영화([https://developers.naver.com/docs/search/movie/](https://developers.naver.com/docs/search/movie/)) 와 조합하여 포스터 이미지를 가져와 리사이징하여 검색 결과 목록에서 보여줍니다.
- 썸네일 사이즈의 리사이징, 상세 보기 사이즈의 리사이징이 모두 필요하며, 두 버전으로 캐싱이 필요합니다.
- 영화 상세보기 기능은 영화진흥위원회 오픈API의 영화 상세정보 API를 활용합니다.
- 일간, 주간 박스오피스 순위 기능은 각각 영화진흥위원회 오픈API의 일별 박스오피스, 주간/주말 박스오피스 API를 활용합니다.
- 응답 예시 
[영화목록 API](http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=f5eef3421c602c6cb7ea224104795888), [영화 상세정보 API](http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079), [일별 박스오피스 API](http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101), [주간/주말 박스오피스 API](http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101)
