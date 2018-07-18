resource "google_project_iam_binding" "main" {
  project            = "${var.project}"
  role               = "${var.role}"
  members            = ["${var.members}"]
}
