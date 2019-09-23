//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift


/*:
 # ReplaySubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

// 생성자가 아닌 create메소드로 생성
// 버퍼의 크기를 3으로 지정하면 3개의 이벤트를 저장하는 버퍼가 생성됨
let replaySubject = ReplaySubject<Int>.create(bufferSize: 3)

// 10개의 Next 이벤트 전달
(1...10).forEach { replaySubject.onNext($0) }

// Subject 구독
replaySubject.subscribe { print("Observer 1 >>", $0) }
	.disposed(by: disposeBag)

// 마지막에 전달된 3개 출력
// Observer 1 >> next(8)
// Observer 1 >> next(9)
// Observer 1 >> next(10)

replaySubject.subscribe { print("Observer 2 >>", $0) }
	.disposed(by: disposeBag)

replaySubject.onNext(11)
// 버퍼에서 가장 오래된 이벤트가 삭제. 즉, 8이 삭제

replaySubject.subscribe { print("Observer 3 >>", $0) }
	.disposed(by: disposeBag)

replaySubject.onCompleted()

// Observer 1 >> next(8)
// Observer 1 >> next(9)
// Observer 1 >> next(10)
// Observer 2 >> next(8)
// Observer 2 >> next(9)
// Observer 2 >> next(10)
// Observer 1 >> next(11)
// Observer 2 >> next(11)
// Observer 3 >> next(9)
// Observer 3 >> next(10)
// Observer 3 >> next(11)
// Observer 1 >> completed
// Observer 2 >> completed
// Observer 3 >> completed

replaySubject.subscribe { print("Observer 4 >>", $0) }
	.disposed(by: disposeBag)

// 버퍼에 저장되어있는 이벤트가 전달된 다음에 Completed이벤트 전달 
// Observer 4 >> next(9)
// Observer 4 >> next(10)
// Observer 4 >> next(11)
// Observer 4 >> completed

// 종료여부와 관계없이 버퍼에 저장되어있는 이벤트를 새로운 구독자에게 전달
