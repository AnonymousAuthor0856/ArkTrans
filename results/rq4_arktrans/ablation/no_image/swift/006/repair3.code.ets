@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      // props: {"hidden":"true"}
      // modifiers: ["statusBar(hidden: true)"]
      // children: 2
      Stack() {
        // === VStack ===
        // props: {"spacing":"0"}
        // children: 2
        Column({ space: 0 }) {
          // === Text ===
          // props: {"text":"Weather","_text_raw":"\"Weather\"",".system(size":"20, weight: .bold)","_positional_raw":["textPrimary",".top","44",".bottom","18"]}
          // modifiers: ["padding(.bottom, 18)","padding(.top, 44)","foregroundColor(textPrimary)","font(.system(size: 20, weight: .bold))"]
          Text('Weather')
            .padding({ bottom: 18 })
            .padding({ top: 44 })
            .fontColor('#000000') // textPrimary approximation
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // === ScrollView ===
          // children: 1
          Scroll() {
            // === VStack ===
            // props: {"spacing":"18","_positional_raw":[".horizontal","14",".bottom","80"]}
            // modifiers: ["padding(.bottom, 80)","padding(.horizontal, 14)"]
            // children: 4
            Column({ space: 18 }) {
              // === VStack ===
              // props: {"spacing":"10","_positional_raw":["18","surfaceColor","14"],"color":".black.opacity(0.12)","radius":"5","x":"0","y":"2"}
              // modifiers: ["shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 2)","cornerRadius(14)","background(surfaceColor)","padding(18)"]
              // children: 4
              Column({ space: 10 }) {
                // === Text ===
                // props: {"_positional_raw":["currentLocation","textPrimary"],".system(size":"16, weight: .semibold)"}
                // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 16, weight: .semibold))"]
                Text('Current Location')
                  .fontColor('#000000')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                // === Text ===
                // props: {"_positional_raw":["temperature","textPrimary"],".system(size":"32, weight: .bold)"}
                // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 32, weight: .bold))"]
                Text('72°')
                  .fontColor('#000000')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)

                // === Text ===
                // props: {"_positional_raw":["condition","textSecondary"],".system(size":"14, weight: .medium)"}
                // modifiers: ["foregroundColor(textSecondary)","font(.system(size: 14, weight: .medium))"]
                Text('Sunny')
                  .fontColor('#666666') // textSecondary approximation
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)

                // === HStack ===
                // props: {"spacing":"0","_positional_raw":[".horizontal","20"]}
                // modifiers: ["padding(.horizontal, 20)"]
                // children: 5
                Row({ space: 0 }) {
                  // === VStack ===
                  // props: {"spacing":"4"}
                  // children: 2
                  Column({ space: 4 }) {
                    // === Text ===
                    // props: {"_positional_raw":["title","textPrimary.opacity(0.7)"],".system(size":"10, weight: .medium)"}
                    // modifiers: ["foregroundColor(textPrimary.opacity(0.7))","font(.system(size: 10, weight: .medium))"]
                    Text('Wind')
                      .fontColor('#999999') // opacity approx
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                    // === Text ===
                    // props: {"_positional_raw":["value","textPrimary"],".system(size":"12, weight: .regular)"}
                    // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                    Text('5 mph')
                      .fontColor('#000000')
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                  }
                  // === Spacer ===
                  Blank()
                  // === VStack ===
                  // props: {"spacing":"4"}
                  // children: 2
                  Column({ space: 4 }) {
                    // === Text ===
                    // props: {"_positional_raw":["title","textPrimary.opacity(0.7)"],".system(size":"10, weight: .medium)"}
                    // modifiers: ["foregroundColor(textPrimary.opacity(0.7))","font(.system(size: 10, weight: .medium))"]
                    Text('Humidity')
                      .fontColor('#999999')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                    // === Text ===
                    // props: {"_positional_raw":["value","textPrimary"],".system(size":"12, weight: .regular)"}
                    // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                    Text('45%')
                      .fontColor('#000000')
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                  }
                  // === Spacer ===
                  Blank()
                  // === VStack ===
                  // props: {"spacing":"4"}
                  // children: 2
                  Column({ space: 4 }) {
                    // === Text ===
                    // props: {"_positional_raw":["title","textPrimary.opacity(0.7)"],".system(size":"10, weight: .medium)"}
                    // modifiers: ["foregroundColor(textPrimary.opacity(0.7))","font(.system(size: 10, weight: .medium))"]
                    Text('UV Index')
                      .fontColor('#999999')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                    // === Text ===
                    // props: {"_positional_raw":["value","textPrimary"],".system(size":"12, weight: .regular)"}
                    // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                    Text('High')
                      .fontColor('#000000')
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                  }
                }.padding({ left: 20, right: 20 })
              }
              .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })
              .borderRadius(14)
              .backgroundColor('#FFFFFF') // surfaceColor
              .padding(18)

              // === VStack ===
              // props: {"alignment":".leading","spacing":"10"}
              // children: 2
              Column({ space: 10 }) {
                // === Text ===
                // props: {"text":"Hourly Forecast","_text_raw":"\"Hourly Forecast\"",".system(size":"16, weight: .semibold)","_positional_raw":["textPrimary"]}
                // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 16, weight: .semibold))"]
                Text('Hourly Forecast')
                  .fontColor('#000000')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                // === ScrollView ===
                // props: {"_positional_raw":[".horizontal"],"showsIndicators":"false"}
                // children: 1
                Scroll() {
                  // === HStack ===
                  // props: {"spacing":"6"}
                  // children: 1
                  Row({ space: 6 }) {
                    // === ForEach ===
                    // props: {"_positional_raw":["hourlyForecast"],"id":"\\.hour"}
                    // children: 1
                    interface HourlyItem {
                      hour: string;
                      temp: string;
                      color: string;
                    }
                    ForEach([
                      { hour: 'Now', temp: '72°', color: '#FFD700' },
                      { hour: '1 PM', temp: '74°', color: '#FFD700' },
                      { hour: '2 PM', temp: '75°', color: '#FFA500' },
                      { hour: '3 PM', temp: '73°', color: '#FFA500' },
                      { hour: '4 PM', temp: '70°', color: '#87CEEB' }
                    ] as HourlyItem[], (item: HourlyItem) => {
                      // === VStack ===
                      // props: {"spacing":"6","width":"70","_positional_raw":["6","surfaceColor","10"],"color":".black.opacity(0.1)","radius":"3","x":"0","y":"1"}
                      // modifiers: ["shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)","cornerRadius(10)","background(surfaceColor)","padding(6)","frame(width: 70)"]
                      // children: 3
                      Column({ space: 6 }) {
                        // === Text ===
                        // props: {"_positional_raw":["hour.hour","textPrimary"],".system(size":"10, weight: .medium)"}
                        // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 10, weight: .medium))"]
                        Text(item.hour)
                          .fontColor('#000000')
                          .fontSize(10)
                          .fontWeight(FontWeight.Medium)
                        // === Circle ===
                        // props: {"_positional_raw":["hour.color"],"width":"20","height":"20"}
                        // modifiers: ["frame(width: 20, height: 20)","fill(hour.color)"]
                        Circle()
                          .width(20)
                          .height(20)
                          .fill(Color(item.color))
                        // === Text ===
                        // props: {"_positional_raw":["hour.temp","textPrimary"],".system(size":"12, weight: .regular)"}
                        // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                        Text(item.temp)
                          .fontColor('#000000')
                          .fontSize(12)
                          .fontWeight(FontWeight.Regular)
                      }
                      .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                      .borderRadius(10)
                      .backgroundColor('#FFFFFF')
                      .padding(6)
                      .width(70)
                    })
                  }
                }
              }

              // === VStack ===
              // props: {"alignment":".leading","spacing":"10"}
              // children: 2
              Column({ space: 10 }) {
                // === Text ===
                // props: {"text":"7-Day Forecast","_text_raw":"\"7-Day Forecast\"",".system(size":"16, weight: .semibold)","_positional_raw":["textPrimary"]}
                // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 16, weight: .semibold))"]
                Text('7-Day Forecast')
                  .fontColor('#000000')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                // === VStack ===
                // props: {"spacing":"6"}
                // children: 1
                Column({ space: 6 }) {
                  // === ForEach ===
                  // props: {"_positional_raw":["weeklyForecast"],"id":"\\.day"}
                  // children: 1
                  interface WeeklyItem {
                    day: string;
                    high: string;
                    low: string;
                    color: string;
                  }
                  ForEach([
                    { day: 'Today', high: '75°', low: '65°', color: '#FFD700' },
                    { day: 'Mon', high: '78°', low: '68°', color: '#FFA500' },
                    { day: 'Tue', high: '72°', low: '62°', color: '#87CEEB' },
                    { day: 'Wed', high: '70°', low: '60°', color: '#A9A9A9' },
                    { day: 'Thu', high: '74°', low: '64°', color: '#FFD700' }
                  ] as WeeklyItem[], (item: WeeklyItem) => {
                    // === HStack ===
                    // props: {"_positional_raw":["14","surfaceColor","6"],"color":".black.opacity(0.1)","radius":"3","x":"0","y":"1"}
                    // modifiers: ["shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)","cornerRadius(6)","background(surfaceColor)","padding(14)"]
                    // children: 4
                    Row() {
                      // === Text ===
                      // props: {"_positional_raw":["day.day","textPrimary"],".system(size":"12, weight: .regular)","width":"40","alignment":".leading"}
                      // modifiers: ["frame(width: 40, alignment: .leading)","foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                      Text(item.day)
                        .width(40)
                        .textAlign(TextAlign.Start)
                        .fontColor('#000000')
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                      // === Circle ===
                      // props: {"_positional_raw":["day.color"],"width":"16","height":"16"}
                      // modifiers: ["frame(width: 16, height: 16)","fill(day.color)"]
                      Circle()
                        .width(16)
                        .height(16)
                        .fill(Color(item.color))
                      // === Spacer ===
                      Blank()
                      // === HStack ===
                      // props: {"spacing":"6"}
                      // children: 2
                      Row({ space: 6 }) {
                        // === Text ===
                        // props: {"_positional_raw":["day.high","textPrimary"],".system(size":"12, weight: .regular)"}
                        // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                        Text(item.high)
                          .fontColor('#000000')
                          .fontSize(12)
                          .fontWeight(FontWeight.Regular)
                        // === Text ===
                        // props: {"_positional_raw":["day.low","textSecondary"],".system(size":"12, weight: .regular)"}
                        // modifiers: ["foregroundColor(textSecondary)","font(.system(size: 12, weight: .regular))"]
                        Text(item.low)
                          .fontColor('#666666')
                          .fontSize(12)
                          .fontWeight(FontWeight.Regular)
                      }
                    }
                    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                    .borderRadius(6)
                    .backgroundColor('#FFFFFF')
                    .padding(14)
                  })
                }
              }

              // === HStack ===
              // props: {"spacing":"0","_positional_raw":["18","surfaceVariant","10"],"color":".black.opacity(0.1)","radius":"3","x":"0","y":"1"}
              // modifiers: ["shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)","cornerRadius(10)","background(surfaceVariant)","padding(18)"]
              // children: 5
              Row({ space: 0 }) {
                // === VStack ===
                // props: {"spacing":"4"}
                // children: 2
                Column({ space: 4 }) {
                  // === Text ===
                  // props: {"_positional_raw":["title","textPrimary.opacity(0.7)"],".system(size":"10, weight: .medium)"}
                  // modifiers: ["foregroundColor(textPrimary.opacity(0.7))","font(.system(size: 10, weight: .medium))"]
                  Text('Sunrise')
                    .fontColor('#999999')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                  // === Text ===
                  // props: {"_positional_raw":["value","textPrimary"],".system(size":"12, weight: .regular)"}
                  // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                  Text('6:12 AM')
                    .fontColor('#000000')
                    .fontSize(12)
                    .fontWeight(FontWeight.Regular)
                }
                // === Spacer ===
                Blank()
                // === VStack ===
                // props: {"spacing":"4"}
                // children: 2
                Column({ space: 4 }) {
                  // === Text ===
                  // props: {"_positional_raw":["title","textPrimary.opacity(0.7)"],".system(size":"10, weight: .medium)"}
                  // modifiers: ["foregroundColor(textPrimary.opacity(0.7))","font(.system(size: 10, weight: .medium))"]
                  Text('Sunset')
                    .fontColor('#999999')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                  // === Text ===
                  // props: {"_positional_raw":["value","textPrimary"],".system(size":"12, weight: .regular)"}
                  // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                  Text('7:45 PM')
                    .fontColor('#000000')
                    .fontSize(12)
                    .fontWeight(FontWeight.Regular)
                }
                // === Spacer ===
                Blank()
                // === VStack ===
                // props: {"spacing":"4"}
                // children: 2
                Column({ space: 4 }) {
                  // === Text ===
                  // props: {"_positional_raw":["title","textPrimary.opacity(0.7)"],".system(size":"10, weight: .medium)"}
                  // modifiers: ["foregroundColor(textPrimary.opacity(0.7))","font(.system(size: 10, weight: .medium))"]
                  Text('Moon Phase')
                    .fontColor('#999999')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                  // === Text ===
                  // props: {"_positional_raw":["value","textPrimary"],".system(size":"12, weight: .regular)"}
                  // modifiers: ["foregroundColor(textPrimary)","font(.system(size: 12, weight: .regular))"]
                  Text('Waxing')
                    .fontColor('#000000')
                    .fontSize(12)
                    .fontWeight(FontWeight.Regular)
                }
              }
              .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
              .borderRadius(10)
              .backgroundColor('#F5F5F5') // surfaceVariant
              .padding(18)
            }
            .padding({ bottom: 80 })
            .padding({ left: 14, right: 14 })
          }
        }

        // === VStack ===
        // props: {"_positional_raw":[".all"],"edges":".bottom"}
        // modifiers: ["ignoresSafeArea(.all, edges: .bottom)"]
        // children: 2
        Column() {
          // === Spacer ===
          Blank()
          // === VStack ===
          // props: {"spacing":"0"}
          // children: 2
          Column({ space: 0 }) {
            // === Rectangle ===
            // props: {"_positional_raw":["Color.clear"],"height":"1"}
            // modifiers: ["frame(height: 1)","fill(Color.clear)"]
            Rect()
              .height(1)
              .fill(Color.Transparent)
            // === HStack ===
            // props: {"spacing":"0","_positional_raw":[".vertical","14","surfaceColor","14"],"corners":"[.topLeft, .topRight]","color":".black.opacity(0.12)","radius":"5","x":"0","y":"-2"}
            // modifiers: ["shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: -2)","cornerRadius(14, corners: [.topLeft, .topRight])","background(surfaceColor)","padding(.vertical, 14)"]
            // children: 7
            Row({ space: 0 }) {
              // === Spacer ===
              Blank()
              // === Button ===
              // props: {"action":"action"}
              // children: 1
              Button() {
                // === Text ===
                // props: {"_positional_raw":["title","10"],".system(size":"10, weight: .medium)","isSelected ? .white":"textPrimary","width":"80","height":"32","isSelected ? primaryBlue":"surfaceVariant"}
                // modifiers: ["cornerRadius(10)","background(isSelected ? primaryBlue : surfaceVariant)","frame(width: 80, height: 32)","foregroundColor(isSelected ? .white : textPrimary)","font(.system(size: 10, weight: .medi...
                Text('Home')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
              }
              .borderRadius(10)
              .backgroundColor('#F5F5F5')
              .width(80)
              .height(32)
              .onClick(() => {})

              // === Spacer ===
              Blank()
              // === Button ===
              // props: {"action":"action"}
              // children: 1
              Button() {
                // === Text ===
                // props: {"_positional_raw":["title","10"],".system(size":"10, weight: .medium)","isSelected ? .white":"textPrimary","width":"80","height":"32","isSelected ? primaryBlue":"surfaceVariant"}
                // modifiers: ["cornerRadius(10)","background(isSelected ? primaryBlue : surfaceVariant)","frame(width: 80, height: 32)","foregroundColor(isSelected ? .white : textPrimary)","font(.system(size: 10, weight: .medi...
                Text('Search')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
              }
              .borderRadius(10)
              .backgroundColor('#F5F5F5')
              .width(80)
              .height(32)
              .onClick(() => {})

              // === Spacer ===
              Blank()
              // === Button ===
              // props: {"action":"action"}
              // children: 1
              Button() {
                // === Text ===
                // props: {"_positional_raw":["title","10"],".system(size":"10, weight: .medium)","isSelected ? .white":"textPrimary","width":"80","height":"32","isSelected ? primaryBlue":"surfaceVariant"}
                // modifiers: ["cornerRadius(10)","background(isSelected ? primaryBlue : surfaceVariant)","frame(width: 80, height: 32)","foregroundColor(isSelected ? .white : textPrimary)","font(.system(size: 10, weight: .medi...
                Text('Profile')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
              }
              .borderRadius(10)
              .backgroundColor('#F5F5F5')
              .width(80)
              .height(32)
              .onClick(() => {})

              // === Spacer ===
              Blank()
            }
            .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
            .borderRadius(14)
            .backgroundColor('#FFFFFF')
            .padding({ top: 14, bottom: 14 })
          }
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}