// Code has been fixed: replaced invalid `.fillColor()` on Circle with `.fill()`.

interface FormStep { title: string; description: string }
interface SupportChip { label: string }
interface SummaryItem { label: string; value: string }

@Entry
@Component
struct ReliefFundApp {
  @State currentStep: number = 1;
  @State name: string = "";
  @State organization: string = "";
  @State contact: string = "";
  @State narrative: string = "";
  @State selectedChip: number = 0;

  private steps: FormStep[] = [
    { title: "Identity", description: "Applicant basics" },
    { title: "Impact", description: "Community reach" },
    { title: "Needs", description: "Immediate relief" },
    { title: "Summary", description: "Confirm details" }
  ];
  private chips: SupportChip[] = [
    { label: "Medical" }, { label: "Shelter" }, { label: "Food" }, { label: "Utilities" }
  ];
  private summary: SummaryItem[] = [
    { label: "Requested", value: "$4,500" },
    { label: "Households", value: "36" },
    { label: "Region", value: "North loop" },
    { label: "Urgency", value: "48h" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle({ width: 30, height: 30 }).fill("#E7D7C2");
        Column() {
          Text("ReliefFund")
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor("#2A1C12");
          Text("Civic support intake")
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor("#2A1C12")
            .opacity(0.7);
        }
        .alignItems(HorizontalAlign.Center);

        Blank();

        Circle({ width: 30, height: 30 }).fill("#B58B5A").opacity(0.35);
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Scrollable Content
      Scroll() {
        Column({ space: 16 }) {
          
          // Steps Card
          Column({ space: 12 }) {
            Text("Steps")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor("#2A1C12");

            ForEach(this.steps, (step: FormStep, index: number) => {
              Row({ space: 12 }) {
                Column() {
                  Circle({ width: 26, height: 26 })
                    .fill(index <= this.currentStep ? "#B58B5A" : "#E7D7C2");
                  
                  if (index !== this.steps.length - 1) {
                    Column()
                      .width(3)
                      .height(28)
                      .backgroundColor("#E7D7C2")
                      .margin({ top: 4 });
                  }
                }
                .alignItems(HorizontalAlign.Center);

                Column({ space: 2 }) {
                  Text(step.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#2A1C12");
                  Text(step.description)
                    .fontSize(13)
                    .fontColor("#2A1C12")
                    .opacity(0.7);
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1);

                Button(index <= this.currentStep ? "Edit" : "Go")
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#2F230C")
                  .backgroundColor("#E5C48F")
                  .borderRadius(8)
                  .height(32)
                  .onClick(() => {
                    this.currentStep = index;
                  });
              }
              .width('100%')
              .alignItems(VerticalAlign.Center);
            });
          }
          .padding(16)
          .backgroundColor("#FFFFFF")
          .borderRadius(24)
          .shadow({ radius: 8, offsetY: 4, color: '#1A000000' });

          // Focus Card
          Column({ space: 12 }) {
            Text("Focus")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor("#2A1C12");

            Row({ space: 12 }) {
              ForEach(this.chips, (chip: SupportChip, index: number) => {
                Text(chip.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#2A1C12")
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(this.selectedChip === index ? "#33B58B5A" : "#E7D7C2")
                  .border({
                    width: 1,
                    color: this.selectedChip === index ? "#B58B5A" : "#C3B09E",
                    radius: 8
                  })
                  .onClick(() => {
                    this.selectedChip = index;
                  });
              });
            }
            .width('100%')
            .alignItems(VerticalAlign.Center);
          }
          .padding(16)
          .backgroundColor("#FFFFFF")
          .borderRadius(24)
          .shadow({ radius: 4, offsetY: 2, color: '#1A000000' });

          // Applicant Details Card
          Column({ space: 12 }) {
            Text("Applicant details")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor("#2A1C12");

            TextInput({ placeholder: "Full name", text: this.name })
              .onChange((value: string) => { this.name = value; })
              .width('100%')
              .height(48)
              .border({ width: 1, color: "#C3B09E", radius: 8 })
              .backgroundColor("#FFFFFF");

            TextInput({ placeholder: "Organization", text: this.organization })
              .onChange((value: string) => { this.organization = value; })
              .width('100%')
              .height(48)
              .border({ width: 1, color: "#C3B09E", radius: 8 })
              .backgroundColor("#FFFFFF");

            TextInput({ placeholder: "Contact", text: this.contact })
              .onChange((value: string) => { this.contact = value; })
              .width('100%')
              .height(48)
              .border({ width: 1, color: "#C3B09E", radius: 8 })
              .backgroundColor("#FFFFFF");

            TextArea({ placeholder: "Relief narrative", text: this.narrative })
              .onChange((value: string) => { this.narrative = value; })
              .width('100%')
              .height(90)
              .border({ width: 1, color: "#C3B09E", radius: 8 })
              .backgroundColor("#FFFFFF");

            Row({ space: 12 }) {
              Button("Back")
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor("#2A1C12")
                .backgroundColor("#E7D7C2")
                .borderRadius(14)
                .layoutWeight(1)
                .height(48)
                .onClick(() => {
                  if (this.currentStep > 0) {
                    this.currentStep -= 1;
                  }
                });

              Button(this.currentStep === this.steps.length - 1 ? "Submit" : "Next")
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor("#2D1A0D")
                .backgroundColor("#B58B5A")
                .borderRadius(14)
                .layoutWeight(1)
                .height(48)
                .onClick(() => {
                  if (this.currentStep < this.steps.length - 1) {
                    this.currentStep += 1;
                  }
                });
            }
            .width('100%');
          }
          .padding(16)
          .backgroundColor("#FFFFFF")
          .borderRadius(24)
          .shadow({ radius: 8, offsetY: 4, color: '#1A000000' });

          // Summary Card
          Column({ space: 8 }) {
            Text("Summary")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor("#2A1C12");

            ForEach(this.summary, (item: SummaryItem) => {
              Row() {
                Text(item.label)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#2A1C12");
                Text(item.value)
                  .fontSize(13)
                  .fontColor("#2A1C12");
              }
              .width('100%')
              .padding(12)
              .backgroundColor("#E7D7C2")
              .borderRadius(14)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);
            });
          }
          .padding(16)
          .backgroundColor("#FFFFFF")
          .borderRadius(24)
          .shadow({ radius: 4, offsetY: 2, color: '#1A000000' });

        }
        .padding({ left: 20, right: 20, top: 12, bottom: 20 });
      }
      .layoutWeight(1)
      .backgroundColor("#F6F0E3")
      .align(Alignment.Top);
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F6F0E3");
  }
}