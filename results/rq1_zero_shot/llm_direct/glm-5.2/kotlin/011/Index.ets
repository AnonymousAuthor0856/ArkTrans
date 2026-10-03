// 008_ForumPost_en.ets
import { Length, Resource, RRect } from '@ohos.arkui';

interface Author {
  name: string;
  avatarColor: ResourceColor;
}

interface Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;
}

interface Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;
}

@Entry
@Component
struct RootScreen {
  @State voteState: number = 1;

  private post: Post = {
    author: { name: "user/compose_master", avatarColor: "#FF76FF03" },
    timestamp: "8 hours ago",
    title: "The power of Jetpack Compose for single-file UIs",
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  };

  private replies: Reply[] = [
    { id: 1, author: { name: "dev/android_fan", avatarColor: "#FFFF00AA" }, timestamp: "7h ago", text: "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.", votes: 25 },
    { id: 2, author: { name: "ux/designer_jane", avatarColor: "#FF00E5FF" }, timestamp: "5h ago", text: "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.", votes: 18 },
    { id: 3, author: { name: "newbie/coder", avatarColor: "#FFFFD600" }, timestamp: "2h ago", text: "I found it a bit overwhelming at first. Any tips for organizing the file?", votes: 3 }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r("sys.media.ohos_ic_back"))
          .width(20).height(20)
          .fillColor("#FF00E5FF")
          .margin({ left: 16 })
        Text("r/jetpackcompose")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor("#FFE0E0FF")
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank().width(20).margin({ right: 16 })
      }
      .width("100%")
      .height(56)
      .backgroundColor("#FF1C1C3A")
      .justifyContent(FlexAlign.SpaceBetween)

      // Content List
      Scroll() {
        Column() {
          // Post Card
          Row() {
            // Vote Column
            Column() {
              Image($r("sys.media.ohos_ic_public_arrow_up_0"))
                .width(24).height(24)
                .fillColor(this.voteState === 1 ? "#FFFF00AA" : "#FF44446A")
                .onClick(() => this.voteState = this.voteState === 1 ? 0 : 1)
              
              Text((this.post.votes + this.voteState - 1).toString())
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.voteState !== 0 ? "#FFFF00AA" : "#FFE0E0FF")
                .margin({ top: 4, bottom: 4 })

              Image($r("sys.media.ohos_ic_public_arrow_down_0"))
                .width(24).height(24)
                .fillColor(this.voteState === -1 ? "#FF00E5FF" : "#FF44446A")
                .onClick(() => this.voteState = this.voteState === -1 ? 0 : -1)
            }
            .margin({ right: 12 })

            // Post Content
            Column() {
              this.AuthorInfo(this.post.author, this.post.timestamp)
              
              Text(this.post.title)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor("#FFE0E0FF")
                .margin({ top: 8 })
              
              Text(this.post.body)
                .fontSize(16)
                .fontColor("#CCE0E0FF")
                .margin({ top: 4 })
              
              Row() {
                Text(`${this.post.commentCount} Comments`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor("#FF44446A")
                  .margin({ right: 24 })
                Text("Share")
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor("#FF44446A")
              }
              .margin({ top: 12 })
            }
            .layoutWeight(1)
          }
          .padding(16)
          .backgroundColor("#FF1C1C3A")
          .margin({ bottom: 8 })

          Text("TOP COMMENTS")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor("#FF44446A")
            .margin({ left: 16, right: 16, top: 8, bottom: 8 })

          ForEach(this.replies, (reply: Reply) => {
            Row() {
              Divider()
                .vertical(true)
                .strokeWidth(2)
                .color(reply.author.avatarColor)
                .height("100%")
                .margin({ right: 12 })

              Column() {
                this.AuthorInfo(reply.author, reply.timestamp)
                Text(reply.text)
                  .fontSize(16)
                  .fontColor("#E6E0E0FF")
                  .margin({ top: 4 })
                Row() {
                  Text(`${reply.votes} votes`)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor("#FF44446A")
                    .margin({ right: 12 })
                  Text("Reply")
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor("#FF44446A")
                }
                .margin({ top: 8 })
              }
              .layoutWeight(1)
            }
            .padding({ left: 16, right: 16, top: 4, bottom: 4 })
            .margin({ bottom: 8 })
          })
        }
      }
      .layoutWeight(1)
      .backgroundColor("#FF101024")

      // Bottom Bar
      Row() {
        Row() {
          Text("Add a comment...")
            .fontSize(16)
            .fontColor("#FF44446A")
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(16)
        .backgroundColor("#FF282850")
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)

        Button("POST") {
          Text("POST")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor("#FF000000")
        }
        .type(ButtonType.Capsule)
        .backgroundColor("#FF00E5FF")
        .margin({ left: 12 })
      }
      .width("100%")
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor("#FF1C1C3A")
    }
    .width("100%")
    .height("100%")
  }

  @Builder
  AuthorInfo(author: Author, timestamp: string) {
    Row() {
      // Avatar
      Stack() {
        Circle({ width: 8, height: 8 }).fill("#33000000");
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(author.avatarColor)
      .margin({ right: 8 })

      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .margin({ right: 8 })

      Text(timestamp)
        .fontSize(14)
        .fontColor("#FF44446A")
    }
    .alignItems(VerticalAlign.Center)
  }
}