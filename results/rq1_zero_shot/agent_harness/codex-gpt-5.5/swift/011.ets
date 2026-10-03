class Author {
  name: string;
  avatarColor: string;

  constructor(name: string, avatarColor: string) {
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
struct ForumPostView {
  @State private voteState: number = 1;
  @State private commentText: string = '';

  private post: Post = new Post(
    new Author('user/compose_master', '#75FF03'),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', '#FF00AA'), '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', '#00E5FF'), '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18)
  ];

  @Builder
  VoteArrow(color: string, down: boolean) {
    Text(down ? '◆' : '◆')
      .fontSize(28)
      .fontColor(color)
      .rotate({ angle: down ? 180 : 0 })
  }

  @Builder
  AuthorInfo(author: Author, timestamp: string) {
    Row() {
      Stack() {
        Circle()
          .width(28)
          .height(28)
          .fill(author.avatarColor)
        Circle()
          .width(10)
          .height(10)
          .fill('#33000000')
      }
      .width(28)
      .height(28)
      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .margin({ left: 10 })
      Text(timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#44446A')
        .margin({ left: 10 })
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoChip(textValue: string) {
    Text(textValue)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#44446A')
  }

  @Builder
  PostCard() {
    Row() {
      Column() {
        Button() {
          this.VoteArrow(this.voteState === 1 ? '#FF00AA' : '#44446A', false)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1;
        })
        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? '#FF00AA' : '#E0E0FF')
          .margin({ top: 10, bottom: 10 })
        Button() {
          this.VoteArrow(this.voteState === -1 ? '#00E5FF' : '#44446A', true)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1;
        })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column() {
        this.AuthorInfo(this.post.author, this.post.timestamp)
        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#E0E0FF')
          .width('100%')
          .margin({ top: 10 })
        Text(this.post.body)
          .fontSize(18)
          .fontColor('#CCE0E0FF')
          .width('100%')
          .margin({ top: 10 })
        Row() {
          this.InfoChip(this.post.commentCount.toString() + ' Comments')
          this.InfoChip('Share')
            .margin({ left: 28 })
        }
        .margin({ top: 20 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding(20)
    .backgroundColor('#1C1C3A')
  }

  @Builder
  ReplyCard(reply: Reply) {
    Row() {
      Rect()
        .width(3)
        .height('100%')
        .radius(1.5)
        .fill(reply.author.avatarColor)
        .opacity(0.5)
      Column() {
        this.AuthorInfo(reply.author, reply.timestamp)
        Text(reply.text)
          .fontSize(18)
          .fontColor('#E6E0E0FF')
          .width('100%')
          .margin({ top: 6 })
        Row() {
          this.InfoChip(reply.votes.toString() + ' votes')
          this.InfoChip('Reply')
            .margin({ left: 16 })
        }
        .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  TopAppBar() {
    Stack() {
      Rect()
        .width('100%')
        .height(60)
        .fill('#1C1C3A')
      Row() {
        Button('‹')
          .fontSize(30)
          .fontColor('#00E5FF')
          .backgroundColor(Color.Transparent)
          .width(50)
          .height(50)
        Blank()
        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0FF')
        Blank()
        Rect()
          .width(50)
          .height(50)
          .fill(Color.Transparent)
      }
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height(60)
  }

  @Builder
  BottomCommentBar() {
    Column() {
      Divider()
        .color('#4D44446A')
        .height(1)
        .margin({ left: 20, right: 20 })
      Row() {
        TextInput({ text: this.commentText, placeholder: 'Add a comment...' })
          .fontSize(18)
          .fontColor('#E0E0FF')
          .placeholderColor('#44446A')
          .backgroundColor('#282850')
          .borderRadius(20)
          .height(52)
          .padding({ left: 20, right: 20 })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.commentText = value;
          })
        Button('POST')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .backgroundColor('#00E5FF')
          .height(52)
          .padding({ left: 20, right: 20 })
          .borderRadius(20)
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#1C1C3A')
    }
    .width('100%')
    .backgroundColor('#1C1C3A')
  }

  build() {
    Column() {
      this.TopAppBar()
      Scroll() {
        Column() {
          this.PostCard()
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#44446A')
            .width('100%')
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          ForEach(this.replies, (reply: Reply) => {
            this.ReplyCard(reply)
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#101024')
      this.BottomCommentBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#101024')
  }
}
