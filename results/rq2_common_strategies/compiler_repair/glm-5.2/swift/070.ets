// index.ets
interface StepRowData {
  step: string;
  title: string;
  subtitle: string;
  btnText: string;
  isActive: boolean;
  isLast: boolean;
}

@Entry
@Component
struct LeaseWizardApp {
  private stepsData: StepRowData[] = [
    { step: "1", title: "Profile", subtitle: "Tenant basics", btnText: "Edit", isActive: true, isLast: false },
    { step: "2", title: "Income", subtitle: "Proof details", btnText: "Edit", isActive: true, isLast: false },
    { step: "3", title: "References", subtitle: "Upload letters", btnText: "Go", isActive: false, isLast: false },
    { step: "4", title: "Summary", subtitle: "Confirm submission", btnText: "Go", isActive: false, isLast: true }
  ];

  build() {
    Column() {
      // Header
      HeaderView()

      // Scrollable Content
      Scroll() {
        Column({ space: 24 }) {
          // Section 1: Steps Container
          Column() {
            Text("Steps")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor("#111827")
              .margin({ bottom: 20 })

            ForEach(this.stepsData, (item: StepRowData) => {
              StepRow({
                step: item.step,
                title: item.title,
                subtitle: item.subtitle,
                btnText: item.btnText,
                isActive: item.isActive,
                isLast: item.isLast
              })
            })
          }
          .padding(24)
          .backgroundColor("#F5F3FD")
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)

          // Section 2: Form Container
          Column() {
            Text("Form")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor("#111827")
              .margin({ bottom: 25 })

            CustomTextField({ label: "Full name", text: "Avery Tenant" })
            CustomTextField({ label: "Contact", text: "avery@example.com" })
          }
          .padding(24)
          .backgroundColor("#F5F3FD")
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FBFBFE")
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle({ width: 44, height: 44 })
        .fill("#EEE9FC")

      Blank()

      // Title Block
      Column() {
        Text("LeaseWizard")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor("#000000")
        Text("Guided handoff")
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor("#6B7280")
      }

      Blank()

      // Right Circle
      Circle({ width: 44, height: 44 })
        .fill("#EEE9FC")
    }
    .width('100%')
    .padding({ top: 10, bottom: 10, left: 20, right: 20 })
  }
}

@Component
struct StepRow {
  @Prop step: string = "";
  @Prop title: string = "";
  @Prop subtitle: string = "";
  @Prop btnText: string = "";
  @Prop isActive: boolean = false;
  @Prop isLast: boolean = false;

  build() {
    Row({ space: 16 }) {
      // Indicator Column
      Column() {
        Stack() {
          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? "#000000" : "#1F2937")
        }
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isActive ? "#A07CFF" : "#EBE7F6")
        .alignContent(Alignment.Center)

        // Vertical Connecting Line
        if (!this.isLast) {
          Line()
            .width(2)
            .height(40)
            .backgroundColor("#EEE9FC")
            .margin({ top: 4 })
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column() {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor("#111827")
          .margin({ top: 4 })

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Normal)
          .fontColor("#6B7280")
          .margin({ top: 2 })

        Blank()
          .height(24)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Action Button
      Button(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor("#2D0D1B")
        .width(60)
        .height(36)
        .backgroundColor("#F4AECF")
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct CustomTextField {
  @Prop label: string = "";
  @Prop text: string = "";

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // The Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .fontColor("#111827")
        Blank()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: "#C4B5FD", radius: 12 })

      // The Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor("#6B7280")
        .padding({ left: 4, right: 4 })
        .backgroundColor("#F5F3FD")
        .margin({ left: 12, top: -10 })
    }
    .width('100%')
    .margin({ bottom: 16 })
  }
}