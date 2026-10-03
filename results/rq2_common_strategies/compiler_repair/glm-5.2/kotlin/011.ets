// 008_ForumPost_en - Social Forum Post - Dark Neon

class Author {
  name: string;
  avatarColor: ResourceColor;

  constructor(name: string, avatarColor: ResourceColor) {
    this.name = name;
    this.avatarColor = avatarColor;
  }
}

class Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id;
    this.author = author;
    this.timestamp = timestamp;
    this.text = text;
    this.votes = votes;
  }
}

class Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author;
    this.timestamp = timestamp;
    this.title = title;
    this.body = body;
    this.votes = votes;
    this.commentCount = commentCount;
  }
}

@Entry
@Component
struct RootScreen {
  @State voteState: number = 1;

  private post: Post = new Post(
    new Author("user/compose_master", "#76FF03"),
    "8 hours ago",
    "The power of Jetpack Compose for single-file UIs",
    "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author("dev/android_fan", "#FF00AA"), "7h ago", "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.", 25),
    new Reply(2, new Author("ux/designer_jane", "#00E5FF"), "5h ago", "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.", 18),
    new Reply(3, new Author("newbie/coder", "#FFD600"), "2h ago", "I found it a bit overwhelming at first. Any tips for organizing the file?", 3)
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("≡")
          .fontSize(24)
          .fontColor("#00E5FF")
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {})
        Text("r/jetpackcompose")
          .fontSize(18)
          .fontColor("#E0E0FF")
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank().width(40)
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor("#1C1C3A")
      .alignItems(VerticalAlign.Center)

      // Content List
      Scroll() {
        Column() {
          // Post Card
          Row() {
            // Vote Column
            Column() {
              Text("▲")
                .fontSize(20)
                .fontColor(this.voteState === 1 ? "#FF00AA" : "#44446A")
                .onClick(() => {
                  this.voteState = this.voteState === 1 ? 0 : 1;
                })
              Text((this.post.votes + this.voteState - 1).toString())
                .fontSize(16)
                .fontColor(this.voteState !== 0 ? "#FF00AA" : "#E0E0FF")
                .fontWeight(FontWeight.Bold)
                .margin({ top: 4, bottom: 4 })
              Text("▼")
                .fontSize(20)
                .fontColor(this.voteState === -1 ? "#00E5FF" : "#44446A")
                .onClick(() => {
                  this.voteState = this.voteState === -1 ? 0 : -1;
                })
            }
            .width(40)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            // Post Content
            Column() {
              // Author Info
              Row() {
                Circle({ width: 24, height: 24 }).fill(this.post.author.avatarColor)
                Text(this.post.author.name)
                  .fontSize(14)
                  .fontColor(this.post.author.avatarColor)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 8 })
                Text(this.post.timestamp)
                  .fontSize(14)
                  .fontColor("#44446A")
                  .margin({ left: 8 })
              }
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: 8 })

              Text(this.post.title)
                .fontSize(22)
                .fontColor("#E0E0FF")
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 8 })

              Text(this.post.body)
                .fontSize(16)
                .fontColor("#E0E0FF")
                .opacity(0.8)
                .lineHeight(24)
                .margin({ bottom: 12 })

              Row() {
                Text(`${this.post.commentCount} Comments`)
                  .fontSize(14)
                  .fontColor("#44446A")
                  .fontWeight(FontWeight.Bold)
                  .margin({ right: 24 })
                Text("Share")
                  .fontSize(14)
                  .fontColor("#44446A")
                  .fontWeight(FontWeight.Bold)
              }
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)
          .backgroundColor("#1C1C3A")
          .alignItems(VerticalAlign.Top)

          // Top Comments Header
          Text("TOP COMMENTS")
            .fontSize(14)
            .fontColor("#44446A")
            .fontWeight(FontWeight.Medium)
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })
            .width('100%')

          // Replies
          ForEach(this.replies, (reply: Reply) => {
            Row() {
              // Color Bar
              Column()
                .width(2)
                .height('100%')
                .backgroundColor(reply.author.avatarColor)
                .opacity(0.5)
                .borderRadius(2)
                .margin({ right: 12 })

              // Reply Content
              Column() {
                Row() {
                  Circle({ width: 24, height: 24 }).fill(reply.author.avatarColor)
                  Text(reply.author.name)
                    .fontSize(14)
                    .fontColor(reply.author.avatarColor)
                    .fontWeight(FontWeight.Bold)
                    .margin({ left: 8 })
                  Text(reply.timestamp)
                    .fontSize(14)
                    .fontColor("#44446A")
                    .margin({ left: 8 })
                }
                .alignItems(VerticalAlign.Center)
                .margin({ bottom: 4 })

                Text(reply.text)
                  .fontSize(16)
                  .fontColor("#E0E0FF")
                  .opacity(0.9)
                  .lineHeight(24)
                  .margin({ bottom: 8 })

                Row() {
                  Text(`${reply.votes} votes`)
                    .fontSize(14)
                    .fontColor("#44446A")
                    .fontWeight(FontWeight.Bold)
                    .margin({ right: 12 })
                  Text("Reply")
                    .fontSize(14)
                    .fontColor("#44446A")
                    .fontWeight(FontWeight.Bold)
                }
                .alignItems(VerticalAlign.Center)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .alignItems(VerticalAlign.Top)
          })
        }
      }
      .layoutWeight(1)
      .backgroundColor("#101024")

      // Bottom Bar
      Row() {
        Row() {
          Text("Add a comment...")
            .fontSize(16)
            .fontColor("#44446A")
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(16)
        .backgroundColor("#282850")
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)

        Button("POST")
          .fontSize(14)
          .fontColor("#000000")
          .fontWeight(FontWeight.Bold)
          .backgroundColor("#00E5FF")
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .margin({ left: 12 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor("#1C1C3A")
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#101024")
  }
}