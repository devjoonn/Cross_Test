# Cross_Test
### 개발 환경
- Base: UIKit
- iOS Target: iOS 13.0
- Design Pattern: MVI
- Library: RxSwift, ReactorKit, Moya, SnapKit, Realm


### Architecture
<img width="950" alt="스크린샷 2024-03-20 오후 3 34 26" src="https://github.com/devjoonn/Cross_Test/assets/82807263/320d8fd6-9e02-4603-afc7-8071dd26f1e6">

Clean-Architecture를 기반으로 PresentationLayer, DomainLayer, DataLayer로 구분하여 각 각의 역할을 분리하였습니다.
Coordinator를 통해 화면 전환과 Factory를 통한 DI 주입을 통해 역할을 분리하였습니다.


### Screen
|즐겨찾기 설정|환율 조회|다크모드|
| --- | --- | --- |
|<img width="240" alt="스크린샷 2024-03-20 오후  3 30 23" src="https://github.com/devjoonn/Cross_Test/assets/82807263/135940e0-d985-4413-be7a-599d4bb28864">|<img width="240" alt="스크린샷 2024-03-20 오후  3 41 17" src="https://github.com/devjoonn/Cross_Test/assets/82807263/4a59d743-d432-4fb9-8f0d-b549817e9b03">|<img width="240" alt="스크린샷 2024-03-20 오후  4 28 38" src="https://github.com/devjoonn/Cross_Test/assets/82807263/8c0f404f-33c8-49a5-a695-b3b3385696b2">

