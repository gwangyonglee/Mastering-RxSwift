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
import RxCocoa

/*:
 # Relay
 */
// Relay는 onCompleted, onError를 전달을 받지도 하지도 않음. Next만 전달
// 구독자가 disposed될 때 까지 종료되지 않기때문에 주로 UI 작업에 사용함.

let disposeBag = DisposeBag()

let publishRelay = PublishRelay<Int>()
publishRelay.subscribe { (print("1: \($0)")) }
	.disposed(by: disposeBag)
// Relay에서는 Next이벤트를 전달할 땐 accept를 사용
publishRelay.accept(1)

// 출력
// 1: next(1)

let behaviorRelay = BehaviorRelay(value: 1)
behaviorRelay.accept(2)

// 가장 최근 next이벤트가 구독자로 전달
behaviorRelay.subscribe{ (print("2: \($0)")) }
	.disposed(by: disposeBag)
// 출력
// 2: next(2)

behaviorRelay.accept(3)
// 2: next(3)

print(behaviorRelay.value)
