@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      // props: {"hidden":"true"}
      // modifiers: ["statusBar(hidden: true)"]
      // children: 1
      Stack() {
        // === VStack ===
        // props: {"spacing":"0"}
        // children: 2
        Column() {
          // === HStack ===
          // props: {"_positional_raw":[".horizontal","20"]}
          // modifiers: ["padding(.horizontal, 20)"]
          // children: 5
          Row() {
            // === Circle ===
            // props: {"_positional_raw":["Color.lwHeaderCircle"],"width":"44","height":"44"}
            // modifiers: ["frame(width: 44, height: 44)","fill(Color.lwHeaderCircle)"]
            Circle().width(44).height(44).fill('#EEE9FC')
            // === Spacer ===
            Blank()
            // === VStack ===
            // props: {"spacing":"2"}
            // children: 2
            Column({ space: 2 }) {
              // === Text ===
              // props: {"text":"LeaseWizard","_text_raw":"\"LeaseWizard\"",".system(size":"18, weight: .bold)","_positional_raw":[".black"]}
              // modifiers: ["foregroundColor(.black)","font(.system(size: 18, weight: .bold))"]
              Text('LeaseWizard').fontColor('#000000').fontSize(18).fontWeight(FontWeight.Bold)
              // === Text ===
              // props: {"text":"Guided handoff","_text_raw":"\"Guided handoff\"",".system(size":"13, weight: .regular)","_positional_raw":[".lwTextGray"]}
              // modifiers: ["foregroundColor(.lwTextGray)","font(.system(size: 13, weight: .regular))"]
              Text('Guided handoff').fontColor('#8E8E93').fontSize(13).fontWeight(FontWeight.Regular)
            }
            // === Spacer ===
            Blank()
            // === Circle ===
            // props: {"_positional_raw":["Color.lwHeaderCircle"],"width":"44","height":"44"}
            // modifiers: ["frame(width: 44, height: 44)","fill(Color.lwHeaderCircle)"]
            Circle().width(44).height(44).fill('#EEE9FC')
          }.padding({ left: 20, right: 20 })

          // === ScrollView ===
          // props: {"showsIndicators":"false"}
          // children: 1
          Scroll() {
            // === VStack ===
            // props: {"spacing":"24","_positional_raw":[".horizontal","16",".bottom","40"]}
            // modifiers: ["padding(.bottom, 40)","padding(.horizontal, 16)"]
            // children: 2
            Column({ space: 24 }) {
              // === VStack ===
              // props: {"alignment":".leading","spacing":"20","_positional_raw":["24","Color.lwCardBg","24"]}
              // modifiers: ["cornerRadius(24)","background(Color.lwCardBg)","padding(24)"]
              // children: 2
              Column() {
                // === Text ===
                // props: {"text":"Steps","_text_raw":"\"Steps\"",".system(size":"22, weight: .bold)","_positional_raw":[".lwTextDark"]}
                // modifiers: ["foregroundColor(.lwTextDark)","font(.system(size: 22, weight: .bold))"]
                Text('Steps').fontColor('#1C1C1E').fontSize(22).fontWeight(FontWeight.Bold)
                // === VStack ===
                // props: {"spacing":"0"}
                // children: 4
                Column() {
                  // === HStack ===
                  // props: {"alignment":".top","spacing":"16"}
                  // children: 4
                  Row({ space: 16 }) {
                    // === VStack ===
                    // props: {"spacing":"0","width":"32"}
                    // modifiers: ["frame(width: 32)"]
                    // children: 2
                    Column() {
                      // === ZStack ===
                      // children: 2
                      Stack() {
                        // === Circle ===
                        // props: {"isActive ? Color(red":"160/255, green: 124/255, blue: 1) : Color.lwPurpleInactive","width":"32","height":"32"}
                        // modifiers: ["frame(width: 32, height: 32)","fill(isActive ? Color(red: 160/255, green: 124/255, blue: 1) : Color.lwPurple..."]
                        Circle().width(32).height(32).fill('#EBE7F6')
                        // === Text ===
                        // props: {"_positional_raw":["step"],".system(size":"14, weight: .medium)","isActive ? .black":".lwTextDark"}
                        // modifiers: ["foregroundColor(isActive ? .black : .lwTextDark)","font(.system(size: 14, weight: .medium))"]
                        Text('1').fontColor('#1C1C1E').fontSize(14).fontWeight(FontWeight.Medium)
                      }
                      // === Rectangle ===
                      // props: {"_positional_raw":["Color.lwHeaderCircle"],"width":"2","minHeight":"40"}
                      // modifiers: ["frame(minHeight: 40)","frame(width: 2)","fill(Color.lwHeaderCircle)"]
                      Rect().height(40).width(2).fill('#EEE9FC')
                    }.width(32)
                    // === VStack ===
                    // props: {"alignment":".leading","spacing":"2"}
                    // children: 3
                    Column({ space: 2 }) {
                      // === Text ===
                      // props: {"_positional_raw":["title",".lwTextDark",".top","4"],".system(size":"17, weight: .semibold)"}
                      // modifiers: ["padding(.top, 4)","foregroundColor(.lwTextDark)","font(.system(size: 17, weight: .semibold))"]
                      Text('Title').padding({ top: 4 }).fontColor('#1C1C1E').fontSize(17).fontWeight(FontWeight.SemiBold)
                      // === Text ===
                      // props: {"_positional_raw":["subtitle",".lwTextGray"],".system(size":"15, weight: .regular)"}
                      // modifiers: ["foregroundColor(.lwTextGray)","font(.system(size: 15, weight: .regular))"]
                      Text('Subtitle').fontColor('#8E8E93').fontSize(15).fontWeight(FontWeight.Regular)
                      // === Spacer ===
                      // props: {"height":"24"}
                      // modifiers: ["frame(height: 24)"]
                      Blank().height(24)
                    }
                    // === Spacer ===
                    Blank()
                    // === Button ===
                    // props: {"action":"{}","_positional_raw":[".top","2"]}
                    // modifiers: ["padding(.top, 2)"]
                    Button() {}.padding({ top: 2 })
                  }
                  // === HStack ===
                  // props: {"alignment":".top","spacing":"16"}
                  // children: 4
                  Row({ space: 16 }) {
                    // === VStack ===
                    // props: {"spacing":"0","width":"32"}
                    // modifiers: ["frame(width: 32)"]
                    // children: 2
                    Column() {
                      // === ZStack ===
                      // children: 2
                      Stack() {
                        // === Circle ===
                        // props: {"isActive ? Color(red":"160/255, green: 124/255, blue: 1) : Color.lwPurpleInactive","width":"32","height":"32"}
                        // modifiers: ["frame(width: 32, height: 32)","fill(isActive ? Color(red: 160/255, green: 124/255, blue: 1) : Color.lwPurple..."]
                        Circle().width(32).height(32).fill('#EBE7F6')
                        // === Text ===
                        // props: {"_positional_raw":["step"],".system(size":"14, weight: .medium)","isActive ? .black":".lwTextDark"}
                        // modifiers: ["foregroundColor(isActive ? .black : .lwTextDark)","font(.system(size: 14, weight: .medium))"]
                        Text('2').fontColor('#1C1C1E').fontSize(14).fontWeight(FontWeight.Medium)
                      }
                      // === Rectangle ===
                      // props: {"_positional_raw":["Color.lwHeaderCircle"],"width":"2","minHeight":"40"}
                      // modifiers: ["frame(minHeight: 40)","frame(width: 2)","fill(Color.lwHeaderCircle)"]
                      Rect().height(40).width(2).fill('#EEE9FC')
                    }.width(32)
                    // === VStack ===
                    // props: {"alignment":".leading","spacing":"2"}
                    // children: 3
                    Column({ space: 2 }) {
                      // === Text ===
                      // props: {"_positional_raw":["title",".lwTextDark",".top","4"],".system(size":"17, weight: .semibold)"}
                      // modifiers: ["padding(.top, 4)","foregroundColor(.lwTextDark)","font(.system(size: 17, weight: .semibold))"]
                      Text('Title').padding({ top: 4 }).fontColor('#1C1C1E').fontSize(17).fontWeight(FontWeight.SemiBold)
                      // === Text ===
                      // props: {"_positional_raw":["subtitle",".lwTextGray"],".system(size":"15, weight: .regular)"}
                      // modifiers: ["foregroundColor(.lwTextGray)","font(.system(size: 15, weight: .regular))"]
                      Text('Subtitle').fontColor('#8E8E93').fontSize(15).fontWeight(FontWeight.Regular)
                      // === Spacer ===
                      // props: {"height":"24"}
                      // modifiers: ["frame(height: 24)"]
                      Blank().height(24)
                    }
                    // === Spacer ===
                    Blank()
                    // === Button ===
                    // props: {"action":"{}","_positional_raw":[".top","2"]}
                    // modifiers: ["padding(.top, 2)"]
                    Button() {}.padding({ top: 2 })
                  }
                  // === HStack ===
                  // props: {"alignment":".top","spacing":"16"}
                  // children: 4
                  Row({ space: 16 }) {
                    // === VStack ===
                    // props: {"spacing":"0","width":"32"}
                    // modifiers: ["frame(width: 32)"]
                    // children: 2
                    Column() {
                      // === ZStack ===
                      // children: 2
                      Stack() {
                        // === Circle ===
                        // props: {"isActive ? Color(red":"160/255, green: 124/255, blue: 1) : Color.lwPurpleInactive","width":"32","height":"32"}
                        // modifiers: ["frame(width: 32, height: 32)","fill(isActive ? Color(red: 160/255, green: 124/255, blue: 1) : Color.lwPurple..."]
                        Circle().width(32).height(32).fill('#EBE7F6')
                        // === Text ===
                        // props: {"_positional_raw":["step"],".system(size":"14, weight: .medium)","isActive ? .black":".lwTextDark"}
                        // modifiers: ["foregroundColor(isActive ? .black : .lwTextDark)","font(.system(size: 14, weight: .medium))"]
                        Text('3').fontColor('#1C1C1E').fontSize(14).fontWeight(FontWeight.Medium)
                      }
                      // === Rectangle ===
                      // props: {"_positional_raw":["Color.lwHeaderCircle"],"width":"2","minHeight":"40"}
                      // modifiers: ["frame(minHeight: 40)","frame(width: 2)","fill(Color.lwHeaderCircle)"]
                      Rect().height(40).width(2).fill('#EEE9FC')
                    }.width(32)
                    // === VStack ===
                    // props: {"alignment":".leading","spacing":"2"}
                    // children: 3
                    Column({ space: 2 }) {
                      // === Text ===
                      // props: {"_positional_raw":["title",".lwTextDark",".top","4"],".system(size":"17, weight: .semibold)"}
                      // modifiers: ["padding(.top, 4)","foregroundColor(.lwTextDark)","font(.system(size: 17, weight: .semibold))"]
                      Text('Title').padding({ top: 4 }).fontColor('#1C1C1E').fontSize(17).fontWeight(FontWeight.SemiBold)
                      // === Text ===
                      // props: {"_positional_raw":["subtitle",".lwTextGray"],".system(size":"15, weight: .regular)"}
                      // modifiers: ["foregroundColor(.lwTextGray)","font(.system(size: 15, weight: .regular))"]
                      Text('Subtitle').fontColor('#8E8E93').fontSize(15).fontWeight(FontWeight.Regular)
                      // === Spacer ===
                      // props: {"height":"24"}
                      // modifiers: ["frame(height: 24)"]
                      Blank().height(24)
                    }
                    // === Spacer ===
                    Blank()
                    // === Button ===
                    // props: {"action":"{}","_positional_raw":[".top","2"]}
                    // modifiers: ["padding(.top, 2)"]
                    Button() {}.padding({ top: 2 })
                  }
                  // === HStack ===
                  // props: {"alignment":".top","spacing":"16"}
                  // children: 4
                  Row({ space: 16 }) {
                    // === VStack ===
                    // props: {"spacing":"0","width":"32"}
                    // modifiers: ["frame(width: 32)"]
                    // children: 2
                    Column() {
                      // === ZStack ===
                      // children: 2
                      Stack() {
                        // === Circle ===
                        // props: {"isActive ? Color(red":"160/255, green: 124/255, blue: 1) : Color.lwPurpleInactive","width":"32","height":"32"}
                        // modifiers: ["frame(width: 32, height: 32)","fill(isActive ? Color(red: 160/255, green: 124/255, blue: 1) : Color.lwPurple..."]
                        Circle().width(32).height(32).fill('#EBE7F6')
                        // === Text ===
                        // props: {"_positional_raw":["step"],".system(size":"14, weight: .medium)","isActive ? .black":".lwTextDark"}
                        // modifiers: ["foregroundColor(isActive ? .black : .lwTextDark)","font(.system(size: 14, weight: .medium))"]
                        Text('4').fontColor('#1C1C1E').fontSize(14).fontWeight(FontWeight.Medium)
                      }
                      // === Rectangle ===
                      // props: {"_positional_raw":["Color.lwHeaderCircle"],"width":"2","minHeight":"40"}
                      // modifiers: ["frame(minHeight: 40)","frame(width: 2)","fill(Color.lwHeaderCircle)"]
                      Rect().height(40).width(2).fill('#EEE9FC')
                    }.width(32)
                    // === VStack ===
                    // props: {"alignment":".leading","spacing":"2"}
                    // children: 3
                    Column({ space: 2 }) {
                      // === Text ===
                      // props: {"_positional_raw":["title",".lwTextDark",".top","4"],".system(size":"17, weight: .semibold)"}
                      // modifiers: ["padding(.top, 4)","foregroundColor(.lwTextDark)","font(.system(size: 17, weight: .semibold))"]
                      Text('Title').padding({ top: 4 }).fontColor('#1C1C1E').fontSize(17).fontWeight(FontWeight.SemiBold)
                      // === Text ===
                      // props: {"_positional_raw":["subtitle",".lwTextGray"],".system(size":"15, weight: .regular)"}
                      // modifiers: ["foregroundColor(.lwTextGray)","font(.system(size: 15, weight: .regular))"]
                      Text('Subtitle').fontColor('#8E8E93').fontSize(15).fontWeight(FontWeight.Regular)
                      // === Spacer ===
                      // props: {"height":"24"}
                      // modifiers: ["frame(height: 24)"]
                      Blank().height(24)
                    }
                    // === Spacer ===
                    Blank()
                    // === Button ===
                    // props: {"action":"{}","_positional_raw":[".top","2"]}
                    // modifiers: ["padding(.top, 2)"]
                    Button() {}.padding({ top: 2 })
                  }
                }
              }.borderRadius(24).backgroundColor('#FFFFFF').padding(24)

              // === VStack ===
              // props: {"alignment":".leading","spacing":"25","_positional_raw":["24","Color.lwCardBg","24"]}
              // modifiers: ["cornerRadius(24)","background(Color.lwCardBg)","padding(24)"]
              // children: 3
              Column() {
                // === Text ===
                // props: {"text":"Form","_text_raw":"\"Form\"",".system(size":"22, weight: .bold)","_positional_raw":[".lwTextDark"]}
                // modifiers: ["foregroundColor(.lwTextDark)","font(.system(size: 22, weight: .bold))"]
                Text('Form').fontColor('#1C1C1E').fontSize(22).fontWeight(FontWeight.Bold)
                // === ZStack ===
                // props: {"alignment":".topLeading"}
                // children: 2
                Stack({ alignContent: Alignment.TopStart }) {
                  // === HStack ===
                  // props: {"_positional_raw":[".vertical","16",".horizontal","16"],"RoundedRectangle(cornerRadius":"12) .stroke(Color.lwBorder, lineWidth: 1)"}
                  // modifiers: ["overlay( RoundedRectangle(cornerRadius: 12) .stroke(Color.lwBorder, lineWidth...","padding(.horizontal, 16)","padding(.vertical, 16)"]
                  // children: 3
                  Row() {
                    // === Text ===
                    // props: {"_positional_raw":["text",".lwTextDark"],".system(size":"18, weight: .regular)"}
                    // modifiers: ["foregroundColor(.lwTextDark)","font(.system(size: 18, weight: .regular))"]
                    Text('Text').fontColor('#1C1C1E').fontSize(18).fontWeight(FontWeight.Regular)
                    // === Spacer ===
                    Blank()
                    // === RoundedRectangle ===
                    // props: {"cornerRadius":"12","_positional_raw":["Color.lwBorder"],"lineWidth":"1"}
                    // modifiers: ["stroke(Color.lwBorder, lineWidth: 1)"]
                    Rect().borderRadius(12).border({ width: 1, color: '#C4B5FD' })
                  }.padding({ left: 16, right: 16, top: 16, bottom: 16 })

                  // === Text ===
                  // props: {"_positional_raw":["label",".lwTextGray",".horizontal","4","Color.lwCardBg"],".system(size":"14, weight: .regular)","x":"12","y":"-10"}
                  // modifiers: ["offset(x: 12, y: -10)","background(Color.lwCardBg)","padding(.horizontal, 4)","foregroundColor(.lwTextGray)","font(.system(size: 14, weight: .regular))"]
                  Text('Label').offset({ x: 12, y: -10 }).backgroundColor('#FFFFFF').padding({ left: 4, right: 4 }).fontColor('#8E8E93').fontSize(14).fontWeight(FontWeight.Regular)
                }
                // === ZStack ===
                // props: {"alignment":".topLeading"}
                // children: 2
                Stack({ alignContent: Alignment.TopStart }) {
                  // === HStack ===
                  // props: {"_positional_raw":[".vertical","16",".horizontal","16"],"RoundedRectangle(cornerRadius":"12) .stroke(Color.lwBorder, lineWidth: 1)"}
                  // modifiers: ["overlay( RoundedRectangle(cornerRadius: 12) .stroke(Color.lwBorder, lineWidth...","padding(.horizontal, 16)","padding(.vertical, 16)"]
                  // children: 3
                  Row() {
                    // === Text ===
                    // props: {"_positional_raw":["text",".lwTextDark"],".system(size":"18, weight: .regular)"}
                    // modifiers: ["foregroundColor(.lwTextDark)","font(.system(size: 18, weight: .regular))"]
                    Text('Text').fontColor('#1C1C1E').fontSize(18).fontWeight(FontWeight.Regular)
                    // === Spacer ===
                    Blank()
                    // === RoundedRectangle ===
                    // props: {"cornerRadius":"12","_positional_raw":["Color.lwBorder"],"lineWidth":"1"}
                    // modifiers: ["stroke(Color.lwBorder, lineWidth: 1)"]
                    Rect().borderRadius(12).border({ width: 1, color: '#C4B5FD' })
                  }.padding({ left: 16, right: 16, top: 16, bottom: 16 })

                  // === Text ===
                  // props: {"_positional_raw":["label",".lwTextGray",".horizontal","4","Color.lwCardBg"],".system(size":"14, weight: .regular)","x":"12","y":"-10"}
                  // modifiers: ["offset(x: 12, y: -10)","background(Color.lwCardBg)","padding(.horizontal, 4)","foregroundColor(.lwTextGray)","font(.system(size: 14, weight: .regular))"]
                  Text('Label').offset({ x: 12, y: -10 }).backgroundColor('#FFFFFF').padding({ left: 4, right: 4 }).fontColor('#8E8E93').fontSize(14).fontWeight(FontWeight.Regular)
                }
              }.borderRadius(24).backgroundColor('#FFFFFF').padding(24)
            }.padding({ left: 16, right: 16, bottom: 40 })
          }
        }
      }
    }.width('100%').height('100%')
  }
}