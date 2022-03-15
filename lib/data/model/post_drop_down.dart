class PostDropDown{
  final String namel;
  PostDropDown({required this.namel});
  static List<PostDropDown> nameList(){
    return <PostDropDown>[
      PostDropDown(namel: "Hide"),
      PostDropDown(namel: "Unfollow"),
      PostDropDown(namel: "Copy Link"),
      PostDropDown(namel: "Report"),
    ];
  }
}