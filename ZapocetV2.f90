program Snehova_koule
    implicit none
    
        integer, parameter :: pole= 150, r_prilip = 2, pocet_castic = 1500
        integer, parameter :: nizni_hranice = 1, vrhni_hranice= pole
        integer, dimension(pole, pole) :: matice
        integer :: castice, io, x, y
    
    
        matice = 0
        matice(pole/2,pole/2) = 1
    
        open(newunit=io, file='dla_data2.txt', status='unknown')
        call random_seed()
    
        do castice = 1, pocet_castic
            call generace_pozice(x, y, nizni_hranice, vrhni_hranice)
            
            do
                call nahodne_posunuti(x,y)
                if (x - r_prilip < 1 .or. x + r_prilip >= pole .or. y - r_prilip < 1 .or. y + r_prilip >= pole) exit
                call overovani_sousedu(r_prilip, x, y, io, matice)    
                
                if (matice(y,x) == 1) exit
                
            end do
        end do
        close(io)
    
        call execute_command_line ("python3 ./zobra.py", wait = .false.)



!-------------------------------------------------------------------------------------------------
        contains
        
        subroutine generace_pozice(x, y, nizni_hranice, vrhni_hranice)
            integer, intent(out) :: x, y
            integer, intent(in) :: nizni_hranice, vrhni_hranice
            real :: rx, ry
        
            call random_number(rx)
            rx = nizni_hranice + rx * (vrhni_hranice - nizni_hranice)
            x = int(rx)
        
            call random_number(ry)
            ry = nizni_hranice + ry * (vrhni_hranice - nizni_hranice)
            y = int(ry)
        end subroutine generace_pozice
        


        subroutine nahodne_posunuti(x, y)
            integer, intent(inout) :: x, y
            integer :: smer
            real :: rsmer
    
            call random_number(rsmer)
            rsmer = 1 + rsmer * 4
            smer = int(rsmer)

            select case(smer)
                case(1) ! nahoru
                    y = min(y+1, pole-1)
                case(2) ! dolu
                    y = max(y-1, 1)
                case(3) ! vlevo
                    x = max(x-1, 1) 
                case(4) ! vpravo
                    x = min(x+1, pole-1)
            end select
        end subroutine nahodne_posunuti


        subroutine overovani_sousedu(r_prilip, x, y, io, matice)
            integer :: radek, sloupec
            integer, intent(in) :: r_prilip, x, y, io
            integer, dimension(pole, pole), intent(inout) :: matice

            particle_loop: do radek = y-r_prilip, y+r_prilip
                    do sloupec = x-r_prilip, x+r_prilip
                        if (matice(radek, sloupec) == 1) then
                            matice(y, x) = 1
                            write(io, *) x, y
                            exit particle_loop 
                        end if
                    end do
            end do particle_loop
        end subroutine
  
    end program
    