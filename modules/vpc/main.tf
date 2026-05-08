resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-vpc"
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-igw"
    }
  )
}

# Public Subnet - AZ A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-public-subnet-a"
    }
  )
}

# Public Subnet - AZ B
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-public-subnet-b"
    }
  )
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-public-rt"
    }
  )
}

# Route Table Association - AZ A
resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Route Table Association - AZ B
resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}