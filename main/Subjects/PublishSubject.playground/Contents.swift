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
 # PublishSubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

// 문자열이 포함된 Next이벤트를 받아서 다른 옵저버에게 전달
let subject = PublishSubject<String>()
subject.onNext("Hello")

// 새로운 옵저버를 추가하고 Subject를 subscribe
let o1 = subject.subscribe { print(">> 1", $0) }
o1.disposed(by: disposeBag)

// PublishSubject로 Next이벤트 전달
subject.onNext("RxSwift")

// 새로운 옵저버 추가
let o2 = subject.subscribe { print(">> 2", $0) }
o2.disposed(by: disposeBag)

// 두 구독자에게 이벤트 전달
subject.onNext("RxSwift2")

// Subject로 Completed 이벤트 전달
subject.onCompleted()

// Subject로 Error 이벤트 전달
//subject.onError(MyError.error)

// Subject가 완료된 이후에 새로운 구독자 추가
let o3 = subject.subscribe { print(">> 3", $0) }
o3.disposed(by: disposeBag)

// Observable에서 Completed가 호출된 이후 더 이상 Next이벤트가 전달되지 않는다. Subject도 동일
