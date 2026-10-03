@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  build() {
    Stack() {
      // === ZStack ===
      // children: 2
      Stack() {
        // === SecureColors ===
        // modifiers: ["ignoresSafeArea()"]
        Column().width('100%').height('100%').backgroundColor('#FFFFFF')

        // === ScrollView ===
        // props: {"showsIndicators":"false"}
        // children: 1
        Scroll() {
          // === VStack ===
          // props: {"alignment":".leading","spacing":"0","_positional_raw":[".horizontal","24"]}
          // modifiers: ["padding(.horizontal, 24)"]
          // children: 12
          Column() {
            // === HStack ===
            // props: {"alignment":".center"}
            // children: 3
            Row() {
              // === VStack ===
              // props: {"alignment":".leading","spacing":"2"}
              // children: 2
              Column() {
                // === Text ===
                // props: {"text":"Welcome back,","_text_raw":"\"Welcome back,\"",".system(size":"14)","_positional_raw":["SecureColors.textGray"]}
                // modifiers: ["foregroundColor(SecureColors.textGray)","font(.system(size: 14))"]
                Text('Welcome back,').fontColor('#808080').fontSize(14)
                // === Text ===
                // props: {"text":"David Miller","_text_raw":"\"David Miller\"",".system(size":"24, weight: .black)","_positional_raw":[".black"]}
                // modifiers: ["foregroundColor(.black)","font(.system(size: 24, weight: .black))"]
                Text('David Miller').fontColor('#000000').fontSize(24).fontWeight(FontWeight.Bold)
              }
              // === Spacer ===
              Blank()
              // === ZStack ===
              // children: 2
              Stack() {
                // === Circle ===
                // props: {"Color(red":"0.96, green: 0.96, blue: 0.96)","width":"48","height":"48","Circle() .stroke(Color(red":"0.88, green: 0.88, blue: 0.88), lineWidth: 1)"}
                // modifiers: ["overlay( Circle() .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidt...","frame(width: 48, height: 48)","fill(Color(red: 0.96, green: 0.96, blue: 0.96))"]
                Circle().fill('#F5F5F5').width(48).height(48).border({ width: 1, color: '#E0E0E0' })
                // === Image ===
                // props: {"systemName":"\"person.fill\"",".system(size":"20)","_positional_raw":[".black"]}
                // modifiers: ["foregroundColor(.black)","font(.system(size: 20))"]
                Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
              }
            }
            // === Spacer ===
            // props: {"height":"40"}
            // modifiers: ["frame(height: 40)"]
            Blank().height(40)
            // === VStack ===
            // props: {"spacing":"0","_positional_raw":["24","SecureColors.surface","24"],"maxWidth":".infinity","RoundedRectangle(cornerRadius":"24) .stroke(SecureColors.border, lineWidth: 1)"}
            // modifiers: ["overlay( RoundedRectangle(cornerRadius: 24) .stroke(SecureColors.border, line...","cornerRadius(24)","background(SecureColors.surface)","frame(maxWidth: .infinity)","padding(24)"]
            // children: 4
            Column() {
              // === Button ===
              // props: {"action":"onToggle","_positional_raw":[".bottom","16"]}
              // modifiers: ["padding(.bottom, 16)"]
              // children: 1
              Button() {
                // === ZStack ===
                // children: 2
                Stack() {
                  // === Circle ===
                  // props: {"_positional_raw":["Color.white"],"width":"80","height":"80","Circle() .stroke(statusColor.opacity(0.1), lineWidth":"2)"}
                  // modifiers: ["overlay( Circle() .stroke(statusColor.opacity(0.1), lineWidth: 2) )","frame(width: 80, height: 80)","fill(Color.white)"]
                  Circle().fill('#FFFFFF').width(80).height(80).border({ width: 2, color: this.isLocked ? '#FFD700' : '#000000' })
                  // === Image ===
                  // props: {"systemName":"isLocked ? \"lock.fill\" : \"checkmark.circle.fill\"",".system(size":"36)","_positional_raw":["statusColor"]}
                  // modifiers: ["foregroundColor(statusColor)","font(.system(size: 36))"]
                  Image(this.isLocked ? $r('app.media.startIcon') : $r('app.media.startIcon')).width(36).height(36).objectFit(ImageFit.Contain)
                }
              }.onClick(() => {
                this.isLocked = !this.isLocked
              }).margin({ bottom: 16 })
              // === Text ===
              // props: {"isLocked ? \"SECURE\"":"\"UNLOCKED\"",".system(size":"22, weight: .black)","_positional_raw":["2","statusColor"]}
              // modifiers: ["foregroundColor(statusColor)","tracking(2)","font(.system(size: 22, weight: .black))"]
              Text(this.isLocked ? 'SECURE' : 'UNLOCKED').fontColor(this.isLocked ? '#FFD700' : '#000000').fontSize(22).fontWeight(FontWeight.Bold).letterSpacing(2)
              // === Spacer ===
              // props: {"height":"8"}
              // modifiers: ["frame(height: 8)"]
              Blank().height(8)
              // === Text ===
              // props: {"isLocked ? \"All perimeter doors are locked.\"":"\"Perimeter access is currently open.\"",".system(size":"14)","_positional_raw":["SecureColors.textGray"]}
              // modifiers: ["foregroundColor(SecureColors.textGray)","font(.system(size: 14))"]
              Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.').fontColor('#808080').fontSize(14)
            }.width('100%').padding(24).backgroundColor('#F5F5F5').borderRadius(24).border({ width: 1, color: '#E0E0E0' })
            // === Spacer ===
            // props: {"height":"32"}
            // modifiers: ["frame(height: 32)"]
            Blank().height(32)
            // === Text ===
            // props: {"text":"My Access Points","_text_raw":"\"My Access Points\"",".system(size":"16, weight: .bold)","Color(white":"0.2)"}
            // modifiers: ["foregroundColor(Color(white: 0.2))","font(.system(size: 16, weight: .bold))"]
            Text('My Access Points').fontColor('#333333').fontSize(16).fontWeight(FontWeight.Bold)
            // === Spacer ===
            // props: {"height":"16"}
            // modifiers: ["frame(height: 16)"]
            Blank().height(16)
            // === VStack ===
            // props: {"spacing":"12"}
            // children: 1
            Column() {
              // === ForEach ===
              // props: {"_positional_raw":["accessPoints"]}
              // children: 1
              ForEach([
                { name: 'Main Entrance', lastAccessed: '2h ago', checked: false },
                { name: 'Garage Door', lastAccessed: '12m ago', checked: true },
                { name: 'Server Room', lastAccessed: 'Yesterday', checked: false }
              ], (item: AccessPointItem) => {
                // === HStack ===
                // props: {"_positional_raw":["16","Color.white","16"],"RoundedRectangle(cornerRadius":"16) .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)"}
                // modifiers: ["overlay( RoundedRectangle(cornerRadius: 16) .stroke(Color(red: 0.93, green: 0...","cornerRadius(16)","background(Color.white)","padding(16)"]
                // children: 3
                Row() {
                  // === HStack ===
                  // props: {"spacing":"16"}
                  // children: 2
                  Row() {
                    // === ZStack ===
                    // children: 2
                    Stack() {
                      // === RoundedRectangle ===
                      // props: {"cornerRadius":"10","Color(red":"0.98, green: 0.98, blue: 0.98)","width":"40","height":"40"}
                      // modifiers: ["frame(width: 40, height: 40)","fill(Color(red: 0.98, green: 0.98, blue: 0.98))"]
                      Rect().fill('#FAFAFA').width(40).height(40).borderRadius(10)
                      // === Image ===
                      // props: {"systemName":"\"house.fill\"",".system(size":"20)","_positional_raw":[".black"]}
                      // modifiers: ["foregroundColor(.black)","font(.system(size: 20))"]
                      Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
                    }
                    // === VStack ===
                    // props: {"alignment":".leading","spacing":"2"}
                    // children: 2
                    Column() {
                      // === Text ===
                      // props: {"_positional_raw":["item.name",".black"],".system(size":"16, weight: .semibold)"}
                      // modifiers: ["foregroundColor(.black)","font(.system(size: 16, weight: .semibold))"]
                      Text(item.name).fontColor('#000000').fontSize(16).fontWeight(FontWeight.Medium)
                      // === Text ===
                      // props: {"_positional_raw":["item.lastAccessed"],".system(size":"11)","Color(white":"0.8)"}
                      // modifiers: ["foregroundColor(Color(white: 0.8))","font(.system(size: 11))"]
                      Text(item.lastAccessed).fontColor('#CCCCCC').fontSize(11)
                    }
                  }
                  // === Spacer ===
                  Blank()
                  // === Toggle ===
                  // props: {"text":"","_text_raw":"\"\"","isOn":"$checked","SwitchToggleStyle(tint":".black)"}
                  // modifiers: ["toggleStyle(SwitchToggleStyle(tint: .black))","labelsHidden()"]
                  Toggle({ type: ToggleType.Switch }).onChange((val: boolean) => {
                    item.checked = val
                  })
                }.width('100%').padding(16).backgroundColor('#FFFFFF').borderRadius(16).border({ width: 1, color: '#EDEDED' })
              })
            }
            // === Spacer ===
            // props: {"height":"32"}
            // modifiers: ["frame(height: 32)"]
            Blank().height(32)
            // === Text ===
            // props: {"text":"Recent Activity","_text_raw":"\"Recent Activity\"",".system(size":"16, weight: .bold)","Color(white":"0.2)"}
            // modifiers: ["foregroundColor(Color(white: 0.2))","font(.system(size: 16, weight: .bold))"]
            Text('Recent Activity').fontColor('#333333').fontSize(16).fontWeight(FontWeight.Bold)
            // === Spacer ===
            // props: {"height":"16"}
            // modifiers: ["frame(height: 16)"]
            Blank().height(16)
            // === VStack ===
            // props: {"spacing":"0"}
            // children: 3
            Column() {
              // === HStack ===
              // props: {"alignment":".center","spacing":"0","_positional_raw":[".vertical","12"]}
              // modifiers: ["padding(.vertical, 12)"]
              // children: 4
              Row() {
                // === Text ===
                // props: {"_positional_raw":["time","SecureColors.textGray"],".system(size":"12)","width":"70","alignment":".leading"}
                // modifiers: ["frame(width: 70, alignment: .leading)","foregroundColor(SecureColors.textGray)","font(.system(size: 12))"]
                Text('10:00 AM').fontColor('#808080').fontSize(12).width(70).textAlign(TextAlign.Start)
                // === Rectangle ===
                // props: {"Color(red":"0.93, green: 0.93, blue: 0.93)","width":"1","height":"20","_positional_raw":[".trailing","16"]}
                // modifiers: ["padding(.trailing, 16)","frame(width: 1, height: 20)","fill(Color(red: 0.93, green: 0.93, blue: 0.93))"]
                Rect().fill('#EDEDED').width(1).height(20).margin({ right: 16 })
                // === VStack ===
                // props: {"alignment":".leading","spacing":"2"}
                // children: 2
                Column() {
                  // === Text ===
                  // props: {"_positional_raw":["event",".black"],".system(size":"14, weight: .medium)"}
                  // modifiers: ["foregroundColor(.black)","font(.system(size: 14, weight: .medium))"]
                  Text('Front door unlocked').fontColor('#000000').fontSize(14).fontWeight(FontWeight.Medium)
                  // === Text ===
                  // props: {"text":"by \\(user)","_text_raw":"\"by \\(user)\"",".system(size":"11)","_positional_raw":["SecureColors.textGray"]}
                  // modifiers: ["foregroundColor(SecureColors.textGray)","font(.system(size: 11))"]
                  Text('by David Miller').fontColor('#808080').fontSize(11)
                }
                // === Spacer ===
                Blank()
              }.width('100%').padding({ top: 12, bottom: 12 })
              // === HStack ===
              // props: {"alignment":".center","spacing":"0","_positional_raw":[".vertical","12"]}
              // modifiers: ["padding(.vertical, 12)"]
              // children: 4
              Row() {
                // === Text ===
                // props: {"_positional_raw":["time","SecureColors.textGray"],".system(size":"12)","width":"70","alignment":".leading"}
                // modifiers: ["frame(width: 70, alignment: .leading)","foregroundColor(SecureColors.textGray)","font(.system(size: 12))"]
                Text('09:45 AM').fontColor('#808080').fontSize(12).width(70).textAlign(TextAlign.Start)
                // === Rectangle ===
                // props: {"Color(red":"0.93, green: 0.93, blue: 0.93)","width":"1","height":"20","_positional_raw":[".trailing","16"]}
                // modifiers: ["padding(.trailing, 16)","frame(width: 1, height: 20)","fill(Color(red: 0.93, green: 0.93, blue: 0.93))"]
                Rect().fill('#EDEDED').width(1).height(20).margin({ right: 16 })
                // === VStack ===
                // props: {"alignment":".leading","spacing":"2"}
                // children: 2
                Column() {
                  // === Text ===
                  // props: {"_positional_raw":["event",".black"],".system(size":"14, weight: .medium)"}
                  // modifiers: ["foregroundColor(.black)","font(.system(size: 14, weight: .medium))"]
                  Text('Garage door opened').fontColor('#000000').fontSize(14).fontWeight(FontWeight.Medium)
                  // === Text ===
                  // props: {"text":"by \\(user)","_text_raw":"\"by \\(user)\"",".system(size":"11)","_positional_raw":["SecureColors.textGray"]}
                  // modifiers: ["foregroundColor(SecureColors.textGray)","font(.system(size: 11))"]
                  Text('by Sarah Jones').fontColor('#808080').fontSize(11)
                }
                // === Spacer ===
                Blank()
              }.width('100%').padding({ top: 12, bottom: 12 })
              // === HStack ===
              // props: {"alignment":".center","spacing":"0","_positional_raw":[".vertical","12"]}
              // modifiers: ["padding(.vertical, 12)"]
              // children: 4
              Row() {
                // === Text ===
                // props: {"_positional_raw":["time","SecureColors.textGray"],".system(size":"12)","width":"70","alignment":".leading"}
                // modifiers: ["frame(width: 70, alignment: .leading)","foregroundColor(SecureColors.textGray)","font(.system(size: 12))"]
                Text('08:30 AM').fontColor('#808080').fontSize(12).width(70).textAlign(TextAlign.Start)
                // === Rectangle ===
                // props: {"Color(red":"0.93, green: 0.93, blue: 0.93)","width":"1","height":"20","_positional_raw":[".trailing","16"]}
                // modifiers: ["padding(.trailing, 16)","frame(width: 1, height: 20)","fill(Color(red: 0.93, green: 0.93, blue: 0.93))"]
                Rect().fill('#EDEDED').width(1).height(20).margin({ right: 16 })
                // === VStack ===
                // props: {"alignment":".leading","spacing":"2"}
                // children: 2
                Column() {
                  // === Text ===
                  // props: {"_positional_raw":["event",".black"],".system(size":"14, weight: .medium)"}
                  // modifiers: ["foregroundColor(.black)","font(.system(size: 14, weight: .medium))"]
                  Text('System armed').fontColor('#000000').fontSize(14).fontWeight(FontWeight.Medium)
                  // === Text ===
                  // props: {"text":"by \\(user)","_text_raw":"\"by \\(user)\"",".system(size":"11)","_positional_raw":["SecureColors.textGray"]}
                  // modifiers: ["foregroundColor(SecureColors.textGray)","font(.system(size: 11))"]
                  Text('by Admin').fontColor('#808080').fontSize(11)
                }
                // === Spacer ===
                Blank()
              }.width('100%').padding({ top: 12, bottom: 12 })
            }
            // === Spacer ===
            // props: {"height":"24"}
            // modifiers: ["frame(height: 24)"]
            Blank().height(24)
          }.width('100%').padding({ left: 24, right: 24 })
        }.scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
      }
    }.width('100%').height('100%')
  }
}

interface AccessPointItem {
  name: string;
  lastAccessed: string;
  checked: boolean;
}