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
 # AsyncSubject
 */
// Publish, Behavior, Replay Subject는 이벤트가 전달되면 즉시 구독자에게 이벤트 전달
// AsyncSubject는 Completed이벤트가 전달되기 전까지 어떤 이벤트도 구독자에게 이벤트를 전달하지 않음.
// Completed이벤트가 전달되면 그 시점에 가장 최근에 전달된 Next 이벤트 1개를 구독자에게 전달.
// Error는 next이벤트가 전달되지 않음.

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let asyncSubject = AsyncSubject<Int>()
asyncSubject.subscribe { print($0) }
	.disposed(by: disposeBag)

asyncSubject.onNext(1)
asyncSubject.onNext(2)
asyncSubject.onNext(3)
asyncSubject.onCompleted()
//asyncSubject.onError(MyError.error)
// 출력
// next(3)
// completed
